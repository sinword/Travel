//
//  LocalSearchService.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/8.
//

import Foundation
import MapKit
import Combine
import CoreLocation

@MainActor
class LocalSearchService: ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion.defaultRegion()
    var locationManager = LocationManager()
    var cancellables = Set<AnyCancellable>()
    @Published var landmarks: [Landmark] = [] // search result
    @Published var landmark: Landmark? // It will be null sometimes
    
    init() {
        locationManager.$region.assign(to: \.region, on: self)
            .store(in: &cancellables)
    }

    func search(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = locationManager.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let response = response {
                let mapItems = response.mapItems
                let sourceLocation = self.getCenterLocation(from: self.locationManager.region)
                self.landmarks = mapItems.map {
                    let destinationLocation = CLLocation(latitude: $0.placemark.coordinate.latitude, longitude: $0.placemark.coordinate.longitude)
                    let distance = self.calculateDistance(from: sourceLocation, to: destinationLocation)
                    return Landmark(placemark: $0.placemark, distance: distance, landmarkName: $0.name ?? "")
                }
            }
            self.landmarks.sort { (landmark1, landmark2) -> Bool in
                return landmark1.distance < landmark2.distance
            }
        }
    }
    
    func update(locationManager: LocationManager) {
        region = locationManager.region
        self.locationManager = locationManager
    }

    func clear() {
        locationManager.$region.assign(to: \.region, on: self)
            .store(in: &cancellables)
        landmarks.removeAll()
    }
    func getCenterLocation(from region: MKCoordinateRegion) -> CLLocation {
        let centerCoordinate = region.center
        return CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
    }
    
    func calculateDistance(from source: CLLocation, to destination: CLLocation) -> CLLocationDistance {
        return source.distance(from: destination)
    }
    
}
