//
//  Landmark.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/8.
//

import Foundation
import MapKit

struct Landmark: Identifiable, Hashable {
    var id = UUID()
    var placemark: MKPlacemark
    var distance: CLLocationDistance
    var landmarkName: String
    
    var name: String {
        self.placemark.name ?? ""
    }
    var title: String {
        self.placemark.title ?? ""
    }
    var coordinate:CLLocationCoordinate2D {
        self.placemark.coordinate
    }
    var formattedDistance: String { // kilometer
        String(format: "%.2f KM", distance / 1000.0)
    }
}
