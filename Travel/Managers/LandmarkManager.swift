//
//  LandmarkManager.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/9.
//

import Foundation
import CoreLocation
import MapKit

class LandmarkManager: NSObject, ObservableObject {
    @Published var landmark: Landmark
    // @Published var region = MKCoordinateRegion.defaultRegion()
    @Published var region: MKCoordinateRegion
    @Published var isEdit: Bool
//    let id = UUID()
//    let placemark: MKPlacemark
//    let distance: CLLocationDistance
    init(landmark: Landmark, region: MKCoordinateRegion) {
        self.landmark = landmark
        self.isEdit = true
        self.region = region
        super.init()
    }
    override init() {
        self.landmark = Landmark(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)), distance: CLLocationDistance(0), landmarkName: "")
        self.isEdit = false
        region = MKCoordinateRegion.defaultRegion()
        super.init()
    }
    
    func update(newLandmark: Landmark) {
        self.landmark = newLandmark
        self.region = MKCoordinateRegion.regionFromLandmark(newLandmark)
        self.isEdit = true
    }
    
    func clear() {
        self.landmark = Landmark(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)), distance: CLLocationDistance(0), landmarkName: "")
        self.isEdit = false
        region = MKCoordinateRegion.defaultRegion()
    }
    
    func printInfo() {
        print("LandmarkManager: \n")
        print("\(self.landmark.id)")
        print("\(self.landmark.name)\n")
        print("\(self.landmark.distance)")
    }
}
