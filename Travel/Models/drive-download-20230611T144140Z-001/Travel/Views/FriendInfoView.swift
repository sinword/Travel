//
//  FriendInfoView.swift
//  Travel
//
//  Created by  陳奕軒 on 2023/6/10.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendInfoView: View {
    @EnvironmentObject var userModel: UserModel
    var body: some View {
        NavigationStack{
            VStack{
                WebImage(url: userModel.user!.profileURL)
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
                    Text(userModel.user!.nickname)
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
                            Text(userModel.user!.nickname)
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
                            Text("This is a note.")
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
