//
//  TripModel.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/11.
//

import Foundation
import Firebase
import FirebaseStorage

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
