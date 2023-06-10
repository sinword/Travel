//
//  FriendInfoView.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/10.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendInfoView: View {
    var body: some View {
        NavigationStack{
            VStack{
                WebImage(url: URL(string: "https://cdn.vox-cdn.com/thumbor/WR9hE8wvdM4hfHysXitls9_bCZI=/0x0:1192x795/1400x1400/filters:focal(596x398:597x399)/cdn.vox-cdn.com/uploads/chorus_asset/file/22312759/rickroll_4k.jpg"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .strokeBorder(Color.black, lineWidth: 5)
                    )
                    .padding([.bottom], 10)
                
                HStack{
                    Text("Rick")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                ZStack{
                    Rectangle()
                        .frame(width: 350, height: 100)
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                    VStack{
                        HStack{
                            Text("暱稱")
                                .font(.title3)
                            Spacer()
                        }.padding([.leading], 20)
                            .padding([.bottom], 5)
                        HStack{
                            Text("Rick")
                                .foregroundColor(.blue)
                            Spacer()
                            
                        }.padding([.leading], 40)
                        
                    }.padding([.bottom], 10)
                }
                ZStack{
                    Rectangle()
                        .frame(width: 350, height: 250)
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                    VStack{
                        HStack{
                            Text("Note")
                                .font(.title3)
                            Spacer()
                        }.padding([.leading], 20)
                            .padding([.bottom], 5)
                        HStack{
                            Text("Never gonna give you up")
                                .foregroundColor(.blue)
                            Spacer()
                            
                        }.padding([.leading], 40)
                    }.padding([.bottom], 150)
                }.padding([.bottom], 25)
                
                Button(action: {print("E")}){
                    Text("Delete")
                        .foregroundColor(.red)
                        .underline()
                        .font(.title2)
                }
            }.padding(20)
        }
    }
    
    func deleteFriend(){
        
    }
}

struct FriendInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FriendInfoView()
    }
}
