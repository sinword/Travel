//
//  FriendView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendView: View {
    @StateObject var friendModel = FriendModel()
    @EnvironmentObject var authModel: AuthModel
    @State var email = ""
    @State var showInputAlert = false
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Friends")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    
                    if friendModel.invitations.isEmpty {
                        Image(systemName: "envelope")
                            .resizable()
                            .frame(width: 40, height: 30)
                    }
                    else{
                        NavigationLink(destination: InvitationView().environmentObject(friendModel)
                            .environmentObject(authModel)
                        ){
                             Image(systemName: "envelope.badge")
                                .resizable()
                                .frame(width: 30, height: 30)
                            }
                    }
                    
                    Button(action: {self.showInputAlert = true}){
                        Image(systemName: "person.fill.badge.plus")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .alert(isPresented: $friendModel.showNotify){
                        Alert(
                            title: Text("通知"),
                            message: Text("好友邀請已送出！"),
                            dismissButton: .default(Text("確認"))
                        )
                    }
                    .alert("Please Enter",isPresented: $showInputAlert){
                        TextField("Email", text: $email)
                            .textCase(.lowercase)
                        Button("Submit", action: submit)
                    } message: {
                        Text("請輸入想要加好友的對象的Email")
                    }
                    .alert(isPresented: $friendModel.showAlert){
                        Alert(
                            title: Text("警告"),
                            message: Text(friendModel.errorMessage),
                            dismissButton: .default(Text("確認"))
                        )
                    }
                }.padding(20)
                if friendModel.userList.isEmpty{
                    Text("You have no friend!")
                }
                else{
                    List(friendModel.userList, id: \.self){ user in
                        HStack{
                            WebImage(url: user.profileURL)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .padding([.trailing], 10)
                            Text("\(user.nickname)")
                                .font(.title2)
                            
                        }
                        .swipeActions(edge: .trailing){
                            Button {
                                friendModel.delFriend(uid: authModel.user?.uid ?? "", targetUid: user.uid)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                            
                            NavigationLink(destination: FriendInfoView().environmentObject(UserModel(uid: user.uid))){
                                Button {
                                } label: {
                                    Label("Info", systemImage: "paperplane")
                                }
                                
                            }.tint(.blue)
                        }
                    }
                }
                
                Spacer()
                
            }.padding(20)
                .onAppear{
                    friendModel.getFriendList(uid: authModel.user?.uid ?? "")
                }
        }
    }
    func submit(){
        friendModel.sendInvitation(uid: authModel.user?.uid ?? "", email: self.email)
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
