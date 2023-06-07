//
//  LandmarkListView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/8.
//

import SwiftUI
import MapKit

struct LandmarkListView: View {
    @EnvironmentObject var localSearchService: LocalSearchService
    var body: some View {
        VStack {
            List(localSearchService.landmarks) { landmark in
                VStack {
                    Text(landmark.name)
                    Text(landmark.title)
                        .opacity(0.5)
                }
                .listRowBackground(localSearchService.landmark == landmark ? Color(UIColor.lightGray): Color.white)
                .onTapGesture {
                    localSearchService.landmark = landmark
                    withAnimation {
                        localSearchService.region = MKCoordinateRegion.regionFromLandmark(landmark)
                    }
                    
                }
            }
        }
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView().environmentObject(LocalSearchService())
    }
}
