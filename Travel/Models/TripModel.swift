//
//  TripModel.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/11.
//

import Foundation
import Firebase
import FirebaseStorage

@MainActor
class TripModel: ObservableObject, Identifiable {
    var id: UUID = UUID()
    @Published var name: String
    @Published var time: Date
    // var member
    @Published var destination: LandmarkManager
    
    
    init() {
        name = ""
        time = Date()
        destination = LandmarkManager()
    }
    
    init(trip: TripModel) {
        name = trip.name
        time = trip.time
        destination = trip.destination
    }
    
    func update(name: String, time: Date, destination: Landmark) {
        self.name = name
        self.time = time
        self.destination.update(newLandmark: destination)
    }
    
    func uploadTrip(newTrip: TripModel, designatedLandmark: LandmarkManager, currentUserID: String) async {
        let ref = Database.database().reference()
        do {
            try await ref.child("Trip/\(newTrip.id)/tripName").setValue(newTrip.name)
            try await ref.child("Trip/\(newTrip.id)/time").setValue(newTrip.time.timeIntervalSince1970)
            try await ref.child("Trip/\(newTrip.id)/destination/destName").setValue(designatedLandmark.landmark.name)
            try await ref.child("Trip/\(newTrip.id)/destination/distance").setValue(designatedLandmark.landmark.distance)
            try await ref.child("Trip/\(newTrip.id)/destination/latitude").setValue(designatedLandmark.landmark.coordinate.latitude)
            try await ref.child("Trip/\(newTrip.id)/destination/longitude").setValue(designatedLandmark.landmark.coordinate.longitude)
            try await ref.child("Trip/\(newTrip.id)/user").setValue(currentUserID)
            
            print("Trip data uploaded successfully")
        }
        catch {
            print("Error uploading trip data")
        }
    }
    
    
    func update(trip: TripModel) {
        self.name = trip.name
        self.time = trip.time
        self.destination.update(newLandmark: trip.destination.landmark)
    }
    
    func printInfo() {
        print("Trip name: \(name)")
        print("Trip time: \(time)")
        print("Trip destination: \n")
        destination.printInfo()
    }
}
