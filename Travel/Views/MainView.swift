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
    @EnvironmentObject var authModel: AuthModel
    
    var body: some View {
        if authModel.isLogin{
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                MapView()
                    .environmentObject(LocalSearchService())
                    .tabItem {
                        Image(systemName: "location.fill")
                        Text("Trip")
                    }
                
                FriendView()
                    .tabItem {
                        Image(systemName: "person.2.fill")
                        Text("People")
                    }
                
                InfoView()
                    .environmentObject(authModel)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Me")
                    }
            }
        }
        else{
            LoginView()
                .environmentObject(authModel)
        }
    }
}

//let authModel = AuthModel()

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(authModel)
    }
}
