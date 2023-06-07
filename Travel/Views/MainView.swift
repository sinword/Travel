//
//  MainView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI

struct MainView: View {
    var body: some View {
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
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Me")
                }
        }
    }
}


    

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
