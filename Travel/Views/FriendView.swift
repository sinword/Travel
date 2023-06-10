//
//  FriendView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Friends")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {print("E")}){
                    Text("Add Friend")
                }
            }.padding(20)
            
            List{
                ForEach(1..<4){ index in
                    HStack{
                        WebImage(url: URL(string: "https://cdn.vox-cdn.com/thumbor/WR9hE8wvdM4hfHysXitls9_bCZI=/0x0:1192x795/1400x1400/filters:focal(596x398:597x399)/cdn.vox-cdn.com/uploads/chorus_asset/file/22312759/rickroll_4k.jpg"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .padding([.trailing], 10)
                        Text("Rick")
                            .font(.title2)
                        
                    }
                    .swipeActions(edge: .trailing){
                        Button {
                            print("Bye")
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                        
                        Button {
                            print("Mark as favorite")
                        } label: {
                            Label("Favorite", systemImage: "paperplane")
                        }
                        .tint(.blue)
                    }
                }
            }
        }.padding(20)
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
