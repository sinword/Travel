//
//  HomeView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var localSearchService: LocalSearchService
    @EnvironmentObject var designatedLandmark: LandmarkManager
    static let lemonGreen = Color("ThemeGreen")
    @State var showDetail = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Travel")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding(.leading, 35)
                    Spacer()
                }
                .padding(.top, 30)
                newTripButtonView
                scheduledTripView
                    .padding(.leading, UIScreen.main.bounds.width * 0.1)
                    .padding(.trailing, UIScreen.main.bounds.width * 0.1)
                    .padding(.top, 20)                
                Spacer()
            }
        }
            
    }
    
    var newTripButtonView: some View {
        HStack {
            Spacer()
            Button(action: {
                designatedLandmark.clear()
                localSearchService.clear()
                showDetail = true
            }) {
                HStack {
                    Image(systemName: "plus")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("New Trip")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: 105)
            .background(HomeView.lemonGreen)
            .cornerRadius(15)
            .shadow(radius: 3, x: 0, y: 2)
            
            NavigationLink(destination: NewTripView(), isActive: $showDetail) {
                EmptyView()
            }
            Spacer()
        }
    
    }
    
    var scheduledTripView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Scheduled Trip")
                .font(.system(size:20))
                .fontWeight(.light)
            Divider()
            HStack {
                Image("TmpImage") // image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 5) {
                    Text("公館夜市之旅") // name
                        .font(.system(size: 18))
                        .fontWeight(.bold)

                    HStack(alignment: .top) {
                        Text("2023/04/20") // date
                        Text("|")
                        Text("18:00") // time
                    }
                    .font(.system(size: 15))
                    .fontWeight(.light)

                    Text("公館夜市") // destination
                        .font(.system(size:15))
                        .fontWeight(.light)
                }
            }
            .padding(.top,-5)
//            NavigationStack {
//                ForEach
//            }
        }
    }
    
    
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LocalSearchService())
            .environmentObject(LandmarkManager())
    }
}
