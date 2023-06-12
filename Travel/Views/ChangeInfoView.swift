//
//  ChangeInfoView.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/12.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI

struct ChangeInfoView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var authModel: AuthModel
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        NavigationStack{
            Spacer()
            VStack{
                HStack{
                    Text("Profile Image")
                        .padding([.trailing], 10)
                    Spacer()
                }
                HStack{
                    if userModel.selectedPhotoData != nil,
                       let image = UIImage(data: userModel.selectedPhotoData!) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                    }else{
                        WebImage(url: userModel.user!.profileURL)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .strokeBorder(Color.black, lineWidth: 5)
                            )
                            .padding([.bottom], 10)
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
                                userModel.selectedPhotoData = data
                            }
                        }
                    }
                    Spacer()
                }
            }
            Spacer()
            VStack{
                HStack{
                    Text("NickName")
                        .padding([.trailing], 10)
                    Spacer()
                }
                HStack{
                    TextField(text: $userModel.nicknameTmp){
                    }
                    Spacer()
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .padding([.bottom], 20)
            }
            Spacer()
            VStack{
                HStack{
                    Text("Note")
                        .padding([.trailing], 10)
                    Spacer()
                }
                HStack{
                    TextField(text: $userModel.noteTmp){
                    }
                    Spacer()
                }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .padding([.bottom], 20)
            }
            Spacer()
            
            Button(action: updateProfile){
                Text("Sumbit")
                    .underline()
            }
            .alert(isPresented: !$userModel.isValid){
                Alert(
                    title: Text("警告"),
                    message: Text(userModel.errorMessage),
                    dismissButton: .default(Text("確認"))
                )
            }
            
            .alert(isPresented: $userModel.sumbitDone){
                Alert(
                    title: Text("通知"),
                    message: Text("修改完成"),
                    dismissButton: .default((Text("確認")), action:
                        authModel.updateUser
                    )
                )
            }
             
            Spacer()
        }
    }
    
    func updateProfile(){
        if userModel.nicknameTmp == ""{
            userModel.isValid = false
            userModel.errorMessage = "暱稱不得為空" 
        }
        else{
            userModel.updateProfile(user: authModel.user!)
        }
    }
    
}

struct ChangeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeInfoView().environmentObject(UserModel(uid: "SXN500spgQhqbvj4LLCeocqlSX43"))
    }
}
