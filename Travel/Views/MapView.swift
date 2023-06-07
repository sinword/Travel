//
//  MapView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @EnvironmentObject var localSearchService: LocalSearchService
    
    @State private var search: String = ""
    var body: some View {
        VStack {
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    localSearchService.search(query: search)
                }
                .padding()
            
            if localSearchService.landmarks.isEmpty {
                Text("Delicious places awaits you!")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 2)
                        )
            }
            else {
                LandmarkListView()
            }
      
            Map(coordinateRegion: $localSearchService.region, showsUserLocation: true, annotationItems: localSearchService.landmarks) { landmark in
                MapAnnotation(coordinate: landmark.coordinate) {
                    Image(systemName: "mappin")
                        .foregroundColor(localSearchService.landmark == landmark ? .yellow: .red)
                        .scaleEffect(localSearchService.landmark == landmark ? 2: 1)
                }
            }
            Spacer()
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView().environmentObject(LocalSearchService())
    }
}
