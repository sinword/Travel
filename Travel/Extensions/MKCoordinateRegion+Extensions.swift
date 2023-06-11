//
//  MKCoordinateRegion+Extensions.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/8.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.013300966542232, longitude: 121.54053908728967), span:
            MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
    
    static func regionFromLandmark(_ landmark: Landmark) -> MKCoordinateRegion {
        MKCoordinateRegion(center: landmark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    }
}
