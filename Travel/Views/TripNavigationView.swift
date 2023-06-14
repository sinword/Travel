//
//  TripNavigationView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/12.
//

import SwiftUI
import MapKit
import CoreLocation

struct TripNavigationView: View {
    @EnvironmentObject var localSearchService: LocalSearchService
    @EnvironmentObject var desginatedTrip: TripModel
//    @EnvironmentObject var desginatedLandmark: LandmarkManager    
    @Environment (\.colorScheme) var colorScheme
    @Environment (\.presentationMode) var presentationMode
    @State private var directions: [String] = []
    @State private var showDirections = false
    
    var body: some View {
        VStack {
            MapRepresentableView(directions: $directions ).environmentObject(desginatedTrip)
           
            Button(action: {
                self.showDirections.toggle()
            }, label: {
                Text("Show direction")
            })
            .disabled(directions.isEmpty)
            .padding()
        }.sheet(isPresented: $showDirections) {
            VStack {
                Text("Directions")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }
            // show directions
            List {
                ForEach(0..<self.directions.count, id: \.self) { index in
                    Text(self.directions[index])
                        .padding()
                }
            }
        }
        
    }
    
    struct TripNavigationView_Previews: PreviewProvider {
        static var previews: some View {
            TripNavigationView()
        }
    }
    
    struct MapRepresentableView: UIViewRepresentable {
        @EnvironmentObject var localSearchService: LocalSearchService
        @EnvironmentObject var designatedTrip: TripModel
        typealias UIViewType = MKMapView
        
        @Binding var directions: [String]
        
        func makeCoordinator() -> MapViewCoordinator {
            return MapViewCoordinator()
        }
        
        func makeUIView(context: Context) -> MKMapView {
            let mapView = MKMapView()
            mapView.delegate = context.coordinator
            mapView.setRegion(localSearchService.region, animated: true)
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow

            Task {
                let source = MKPlacemark(coordinate: mapView.userLocation.coordinate)
                let destination = MKPlacemark(coordinate: designatedTrip.destination.landmark.coordinate)

                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: source)
                request.destination = MKMapItem(placemark: destination)
                request.transportType = .walking

                let directions = MKDirections(request: request)

                directions.calculate { response, error in
                    guard let route = response?.routes.first else { return }

                    let annotation = MKPointAnnotation()
                    annotation.coordinate = destination.coordinate
                    annotation.title = ""
                    mapView.addAnnotation(annotation)
                    mapView.addOverlay(route.polyline)
                    mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
                    self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
                }
            }

            return mapView
        }
        
        
        
        func updateUIView(_ uiView: MKMapView, context: Context) {
            
        }
        
        class MapViewCoordinator: NSObject, MKMapViewDelegate {
            func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = .systemBlue
                renderer.lineWidth = 5
                return renderer
            }
            
        }
    }
}
