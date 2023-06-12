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
    @EnvironmentObject var authModel : AuthModel
    var body: some View {
        VStack{
            Text("好友邀請")
                .font(.title)
            if friendModel.invitations.isEmpty{
                Text("No invitations!")
            }
            else{
                List(friendModel.invitations, id: \.self){ user in
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
                            friendModel.delFriendInvitation(uid: authModel.user!.uid ?? "", targetUid: user.uid)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                        
                      
                        Button {
                            friendModel.addFriend(uid: authModel.user!.uid ?? "", targetUid: user.uid)
                        } label: {
                            Label("Info", systemImage: "checkmark")
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
