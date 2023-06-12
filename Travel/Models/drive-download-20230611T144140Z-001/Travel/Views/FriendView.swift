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
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Friends")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    
                    NavigationLink(destination: InvitationView().environmentObject(friendModel)){
                        if friendModel.invitations.isEmpty {
                            Image(systemName: "envelope")
                                .resizable()
                                .frame(width: 40, height: 30)
                        }
                        else{
                            Button(action: {print("E")}){
                                Image(systemName: "envelope.badge")
                                    .resizable()
                                    .frame(width: 40, height: 30)
                            }
                        }
                    }
                    
                    Button(action: {print("E")}){
                        Image(systemName: "person.fill.badge.plus")
                            .resizable()
                            .frame(width: 40, height: 30)
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
                                friendModel.getUIDFromMail(email: "Josephchen102345@gmail.com")
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
                
                
            }.padding(20)
                .onAppear{
                    print(authModel.user?.uid)
                    friendModel.getFriendList(uid: authModel.user?.uid ?? "")
                }
        }
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
