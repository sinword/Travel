//
//  InvitationView.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/11.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct InvitationView: View {
    @EnvironmentObject var friendModel : FriendModel
    
    var body: some View {
        VStack{
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
    }
    
}

struct InvitationView_Previews: PreviewProvider {
    static var previews: some View {
        InvitationView().environmentObject(FriendModel())
    }
}
