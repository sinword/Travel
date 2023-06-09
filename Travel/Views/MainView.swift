//
//  MainView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI
import Firebase

prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}

struct MainView: View {
    @EnvironmentObject var user: UserSettings
    
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(user)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .fullScreenCover(isPresented: !$user.isLogin){
                    LoginView().environmentObject(user)
               }
            MapView()
                .environmentObject(LocalSearchService())
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("Trip")
                }

            FriendView()
                .environmentObject(user)
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("People")
                }

            InfoView()
                .environmentObject(user)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Me")
                }
        }
    }
}


let user = UserSettings()

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(user)
    }
}
