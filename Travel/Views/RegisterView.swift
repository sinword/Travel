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
    @State private var selectedItem: PhotosPickerItem?
    @State private var signUpSuccess = false
    @State private var showAlert = false
    
    @EnvironmentObject var authModel: AuthModel
    
    @Environment(\.dismiss) var dismiss
    
    
    func signUpWithEmail(){
        if authModel.password != authModel.confirmPassword{
            authModel.isValid = false
            authModel.errorMessage = "兩次密碼不相符"
        }
        else if authModel.email.isEmpty{
            authModel.isValid = false
            authModel.errorMessage = "電子郵件不得為空"
        }
        else if authModel.password.isEmpty{
            authModel.isValid = false
            authModel.errorMessage = "密碼不得為空"
        }
        else if authModel.nickname.isEmpty{
            authModel.isValid = false
            authModel.errorMessage = "暱稱不得為空"
        }
        else{
            Task{
                if try await authModel.signUpWithEmail(){
                    
                }
            }
        }
    }
    
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
                    
                    TextField("Email", text: $authModel.email)
                        .textFieldStyle(.plain)
                        .frame(height: 20)
                        .padding(.leading)
                        .offset(x: -10)
                        .textCase(.lowercase)
                    
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
                    SecureField("密碼", text: $authModel.password)
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
                    SecureField("確認密碼", text: $authModel.confirmPassword)
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
                    TextField("暱稱", text: $authModel.nickname)
                        .textFieldStyle(.plain)
                        .frame(height: 20)
                        .padding(.leading)
                        .offset(x: -10)
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .padding([.bottom], 20)
                }
                
                VStack(){
                    EmptyView()
                    
                    
                    HStack(){
                        Text("顯示圖片")
                            .fontWeight(.black)
                        Spacer()
                    }
                    
                    HStack(){
                        if let image = UIImage(data: authModel.selectedPhotoData!) {
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
                                    authModel.selectedPhotoData = data
                                }
                            }
                        }
                        
                        Spacer()
                        Button(action: signUpWithEmail){
                            Text("註冊")
                                .frame(width: 60)
                                .padding(10)
                        }
                        .alert(isPresented: !$authModel.isValid){
                            Alert(
                                title: Text("警告"),
                                message: Text(authModel.errorMessage),
                                dismissButton: .default(Text("確認"))
                            )
                        }
                        .alert(isPresented: $authModel.isSignUp){
                            Alert(
                                title: Text("通知"),
                                message: Text("您已註冊完成"),
                                dismissButton: .default(Text("確認"), action: {
                                    //dismiss()
                                })
                            )
                        }
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(20)
        
                    }.padding([.leading], 10)
                }
                Spacer()
                
            }.padding(20)
        }
    }
    
   
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            //.environmentObject(authModel)
    }
}



