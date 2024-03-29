//
//  TripModel.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/11.
//

import Foundation
import Firebase
import FirebaseStorage

class TripModel: ObservableObject {
    @Published var name: String
    @Published var time: Date
    // var member
    @Published var destination: LandmarkManager
    
    init() {
        name = ""
        time = Date()
        destination = LandmarkManager()
    }
    
    func update(name: String, time: Date, destination: Landmark) {
        self.name = name
        self.time = time
        self.destination.update(newLandmark: destination)
    }
    
    func printInfo() {
        print("Trip name: \(name)")
        print("Trip time: \(time)")
        print("Trip destination: \n")
        destination.printInfo()
    }
    
    
}
