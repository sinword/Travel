    //
    //  TripManager.swift
    //  Travel
    //
    //  Created by 新翌王 on 2023/6/12.
    //

    import Foundation
    import MapKit

    class TripManager: NSObject, ObservableObject {
        @Published var trips: [TripModel]
        
        override init() {
            trips = []
        }
        
        func addTrip(newTrip: TripModel) {
            trips.append(newTrip)
        }
        
        func updateTrip(editedTrip: TripModel) {
            for trip in trips {
                if trip.id == editedTrip.id {
                    trip.name = editedTrip.name
                    trip.time = editedTrip.time
                    trip.destination = editedTrip.destination
                    break
                }
            }
        }
        
        func copyTrips(trips: [TripModel]) {
            self.trips = trips
        }
        
        func printInfo() {
            var index = 0
            print("Current trip number: \(trips.count)")
            while (index < trips.count) {
                print("Trip \(index)")
                trips[index].printInfo()
                index += 1
            }
        }
    }
