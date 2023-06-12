//
//  InfoView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct InfoView: View {
    @EnvironmentObject var authModel: AuthModel
    var body: some View {
        NavigationStack(){
            VStack{
                VStack{
                    HStack{
                        WebImage(url: authModel.user?.photoURL)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .padding([.trailing], 10)
                        Text(authModel.user?.displayName ?? "NULL")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }.padding([.leading], 20)
                    Rectangle()
                        .frame(width: 350, height: 1)
                    
                }.padding([.bottom], 10)
                
                VStack{
                    HStack{
                        Text("個人資料")
                            .font(.title3)
                            .fontWeight(.black)
                        Spacer()
                    }
                    HStack{
                        NavigationLink(destination: FriendInfoView().environmentObject(UserModel(uid: authModel.user!.uid))){
                            Text("我的資訊")
                        } .foregroundColor(.black)
                        Spacer()
                    }.padding([.leading], 10)
                        .padding([.top], 5)
                    
                    HStack{
                        NavigationLink(destination: ChangeInfoView().environmentObject(authModel) .environmentObject(UserModel(uid: authModel.user!.uid))){
                            Text("修改個人顯示")
                        } .foregroundColor(.black)
                        Spacer()
                    }.padding([.leading], 10)
                        .padding([.top], 5)
                    
                    HStack{
                        Button(action: authModel.changePassword){
                            Text("修改密碼")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }.padding([.leading], 10)
                        .padding([.top], 5)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                    
                }.padding([.leading, .bottom], 5)
                /*
                VStack{
                    HStack{
                        Text("偏好設定")
                            .font(.title3)
                            .fontWeight(.black)
                        Spacer()
                    }
                    HStack{
                        Button(action: {logout()}){
                            Text("封鎖名單")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }.padding([.leading], 10)
                        .padding([.top], 5)
                    
                    HStack{
                        Button(action: {logout()}){
                            Text("通知設定")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }.padding([.leading], 10)
                        .padding([.top], 5)
                    
                    HStack{
                        Button(action: {logout()}){
                            Text("語言設定")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }.padding([.leading], 10)
                        .padding([.top], 5)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                    
                }.padding([.leading, .bottom], 5)
                */
                VStack{
                    HStack{
                        Text("關於")
                            .font(.title3)
                            .fontWeight(.black)
                        Spacer()
                    }
                    HStack{
                        NavigationLink(destination: TextFileView(fileName: "關於我們")){
                            Text("關於我們")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }.padding([.leading], 10)
                        .padding([.top], 5)
                    
                    HStack{
                        NavigationLink(destination: TextFileView(fileName: "常見問題")){
                            Text("常見問題")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }.padding([.leading], 10)
                        .padding([.top], 5)
                    
                    HStack{
                        NavigationLink(destination: TextFileView(fileName: "版本紀錄")){
                            Text("版本紀錄")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }.padding([.leading], 10)
                        .padding([.top], 5)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                    
                }.padding([.leading, .bottom], 5)
                
                VStack{
                    HStack{
                        Text("帳號管理")
                            .font(.title3)
                            .fontWeight(.black)
                        Spacer()
                    }   .padding([.leading], 10)
                        .padding([.top], 5)
                    HStack{
                        Button(action: authModel.signOut){
                            Text("登出")
                                .frame(width: 60)
                        }
                        Spacer()
                    }.padding([.leading], 10)
                        .padding([.top], 5)
                }
                
                Spacer()
            }
        }.padding(20)
    
    }
    func logout(){
        
    }
}
//let authModel = AuthModel()

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            //.environmentObject(authModel)
    }
}
