//
//  TripManager.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/12.
//

import Foundation
import MapKit
import Firebase

@MainActor
class TripManager: NSObject, ObservableObject {
    @Published var trips = [TripModel]()
    var uid = ""
    
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

    
    
    func getAllTrips(currentUserUID: String) {
        var trip = TripModel()
        let ref = Database.database().reference().child("Trip")
        self.trips.removeAll()
        
        ref.observeSingleEvent(of: .value) { snapshot, error in
               guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                   print("Failed to retrieve trips")
                   return
               }
               
               for tripSnapshot in snapshot {
                   guard let tripDict = tripSnapshot.value as? NSDictionary,
                         let userUID = tripDict["user"] as? String else {
                       continue
                   }
                   
                   if userUID == currentUserUID {
                       // User matches, retrieve the trip details
                       let tripName = tripDict["tripName"] as? String ?? ""
                       let timeInterval = tripDict["time"] as? Double ?? 0
                       let destName = tripDict["destination/destName"] as? String ?? ""
                       let latitude = tripDict["destination/latitude"] as? Double ?? 0
                       let longitude = tripDict["destination/longitude"] as? Double ?? 0
                       let distance = tripDict["destination/distance"] as? Double ?? 0
                       
                       // Create trip model or perform further actions
                       let trip = TripModel()
                       trip.id = UUID(uuidString: tripSnapshot.key)!
                       trip.name = tripName
                       trip.time = Date(timeIntervalSince1970: timeInterval)
                       
                       let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                       let placemark = MKPlacemark(coordinate: coordinate)
                       let landmark = Landmark(placemark: placemark, distance: distance, landmarkName: destName)
                       let landmarkManager = LandmarkManager()
                       landmarkManager.update(newLandmark: landmark)
                       
                       trip.destination = landmarkManager
                       self.trips.append(trip)
                       
                       // Do something with the trip
                       print("Found trip: \(trip.id)")
                       trip.printInfo()
                   }
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
