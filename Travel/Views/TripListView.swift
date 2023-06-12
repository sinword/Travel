//
//  TripListView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/12.
//
import SwiftUI
import MapKit

struct TripListView: View {
    @EnvironmentObject var tripManager: TripManager
    var body: some View {
        let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                return formatter
            }()
        
        NavigationView {
            List(tripManager.trips) { trip in
                NavigationLink(destination: EditTripView()) {
                    VStack(alignment: .leading) {
                        Text(trip.name)
                        Text(dateFormatter.string(from: trip.time))
                            .opacity(0.5)
                        Text(trip.destination.landmark.name)
                            .opacity(0.5)
                    }.padding()
                }
                .navigationTitle("Trip List")
            }
        }
    }
}



struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
