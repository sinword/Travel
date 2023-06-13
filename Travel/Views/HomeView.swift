//
//  HomeView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var authModel: AuthModel
    @EnvironmentObject var localSearchService: LocalSearchService
    @EnvironmentObject var designatedLandmark: LandmarkManager
    @EnvironmentObject var tripManager: TripManager
    static let lemonGreen = Color("ThemeGreen")
    @State var showNewTripView = false
    @State var showEditTripView = false
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        return formatter
    }()
    
    
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
              
                List(tripManager.trips, id: \.id) { trip in
                    NavigationLink(destination: TripNavigationView()
                        .environmentObject(trip)) {
                        VStack(alignment: .leading) {
                            Text(trip.name)
                            Text(dateFormatter.string(from: trip.time))
                                .opacity(0.5)
                            Text(trip.destination.landmark.landmarkName)
                                .opacity(0.5)
                        }
                    }
                }
                
                .padding(.top, 30)
                Spacer()
            }
            .onAppear {
                tripManager.getAllTrips(currentUserUID: authModel.user!.uid)
                print("Tab View trip update")
            }
        }
        
    }
    
    
    var newTripButtonView: some View {
        HStack {
            Spacer()
            Button(action: {
                designatedLandmark.clear()
                localSearchService.clear()
                showNewTripView = true
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
            
            NavigationLink(destination: NewTripView().environmentObject(tripManager).environmentObject(authModel), isActive: $showNewTripView) {
                EmptyView()
            }
            Spacer()
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
