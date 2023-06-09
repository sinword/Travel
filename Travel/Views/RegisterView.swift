//
//  RegisterView.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/8.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

struct RegisterView: View {
    @State var email = ""
    @State var passwd = ""
    @State var passwdCheck = ""
    @State var phoneNumber = ""
    @State var nickname = ""
    @State var showAlert = false
    @State var errorMsg = ""
    @State var regSuccess = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data? = UIImage(systemName: "person.circle.fill")?.pngData() //Default
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            VStack{
                Spacer()
                
                VStack(){
                    HStack(){
                        Text("電子郵件")
                            .fontWeight(.black)
                        Spacer()
                    }
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(.plain)
                        .frame(height: 20)
                        .padding(.leading)
                        .offset(x: -10)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .padding([.bottom], 20)
                }
                VStack(){
                    HStack(){
                        Text("密碼")
                            .fontWeight(.black)
                        Spacer()
                    }
                    SecureField("密碼", text: $passwd)
                        .textFieldStyle(.plain)
                        .frame(height: 20)
                        .padding(.leading)
                        .offset(x: -10)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .padding([.bottom], 20)
                }
                VStack(){
                    HStack(){
                        Text("確認密碼")
                            .fontWeight(.black)
                        Spacer()
                    }
                    SecureField("確認密碼", text: $passwdCheck)
                        .textFieldStyle(.plain)
                        .frame(height: 20)
                        .padding(.leading)
                        .offset(x: -10)
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .padding([.bottom], 20)
                }
                /*
                VStack(){
                    HStack(){
                        Text("手機號碼")
                            .fontWeight(.black)
                        Spacer()
                    }
                    TextField("手機號碼", text: $phoneNumber)
                        .textFieldStyle(.plain)
                        .frame(height: 20)
                        .padding(.leading)
                        .offset(x: -10)
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .padding([.bottom], 20)
                }
                */
                VStack(){
                    HStack(){
                        Text("暱稱")
                            .fontWeight(.black)
                        Spacer()
                    }
                    TextField("暱稱", text: $nickname)
                        .textFieldStyle(.plain)
                        .frame(height: 20)
                        .padding(.leading)
                        .offset(x: -10)
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .padding([.bottom], 20)
                }
                
                VStack(){
                    HStack(){
                        Text("顯示圖片")
                            .fontWeight(.black)
                        Spacer()
                    }
                     
                    HStack(){
                        if let selectedPhotoData,
                            let image = UIImage(data: selectedPhotoData) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())

                        }else{
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        
                        PhotosPicker(selection: $selectedItem, matching: .images){
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .padding([.leading], 10)
                        .onChange(of: selectedItem){
                            newItem in Task{
                                if let data = try? await
                                    newItem?.loadTransferable(type: Data.self){
                                    selectedPhotoData = data
                                }
                            }
                        }
                        
                        Spacer()
                        Button(action: {register()}){
                            Text("註冊")
                                .frame(width: 60)
                                .padding(10)
                        }
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(20)
                        .alert(isPresented: $showAlert){
                            Alert(
                                title: Text("警告"),
                                message: Text(errorMsg),
                                dismissButton: .default(Text("確認"))
                            )
                        }
                        
                        .alert(isPresented: $regSuccess){
                            Alert(
                                title: Text("通知"),
                                message: Text("您已註冊完成"),
                                dismissButton: .default(Text("確認"), action: {
                                    dismiss()
                                })
                            )
                        }
                        
                    }.padding([.leading], 10)
                }
                Spacer()
                
            }.padding(20)
        }
    }

    func register(){
        if passwd != passwdCheck{
            showAlert = true
            errorMsg = "兩次密碼不相符"
        }
        else if email.isEmpty{
            showAlert = true
            errorMsg = "電子郵件不得為空"
        }
        else if passwd.isEmpty{
            showAlert = true
            errorMsg = "密碼不得為空"
        }
        else if nickname.isEmpty{
            showAlert = true
            errorMsg = "暱稱不得為空"
        }
        /*
         else if phoneNumber.isEmpty{
             showAlert = true
             errorMsg = "電話號碼不得為空"
         }
         */
        else{
            Auth.auth().createUser(withEmail: email, password: passwd){
                // Register
                authResult, error in
                guard let user = authResult?.user, error == nil else{
                    showAlert = true
                    errorMsg = error!.localizedDescription
                    return
                }
                print("\(user.email!) created")
                // Image
                self.uploadImage(UID: user.uid)
                // NickName
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = nickname
                changeRequest?.photoURL = URL(string: "\(user.uid)/Profile.png")
                changeRequest?.commitChanges{ error in
                    if error != nil{
                        showAlert = true
                        errorMsg = error!.localizedDescription
                        return
                    }
                }
                regSuccess = true
            }
        }
    }
    
    func uploadImage(UID: String){
        guard let data = selectedPhotoData else {
            showAlert = true
            errorMsg = "請上傳有效圖片"
            return
        } // Checks whether there is actual data to upload.
        
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("\(UID)/Profile.png")
        
        let uploadTask = fileRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                showAlert = true
                errorMsg = error!.localizedDescription
                return
            } // Cancels task if there is any error
            /*
            fileRef.downloadURL { (url, error) in {
                guard let downloadURL = url else { return }
                print(downloadURL) // Prints the URL to the newly uploaded data.
            }
            }*/
            
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}



