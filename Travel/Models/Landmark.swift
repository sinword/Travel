//
//  Landmark.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/8.
//

import Foundation
import MapKit

struct Landmark: Identifiable, Hashable {
    let placemark: MKPlacemark
    let id = UUID()
    
    var name: String {
        self.placemark.name ?? ""
    }
    var title: String {
        self.placemark.title ?? ""
    }
    var coordinate:CLLocationCoordinate2D {
        self.placemark.coordinate
        
    }
}
