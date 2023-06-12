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
    @EnvironmentObject var designatedLandmark: LandmarkManager
    var body: some View {
        VStack {
            List(localSearchService.landmarks) { landmark in
                VStack(alignment: .leading) {
                    Text(landmark.name)
                    Text(landmark.formattedDistance)
                    Text(landmark.title)
                        .opacity(0.5)
                }
                .listRowBackground(localSearchService.landmark == landmark ? Color(UIColor.systemGray2): Color.white)
                .onTapGesture {
                    localSearchService.landmark = landmark
                    designatedLandmark.update(newLandmark: landmark)
                    withAnimation {
                        localSearchService.region = MKCoordinateRegion.regionFromLandmark(landmark)
                    }
                }
                
            }
        }
        .padding(.top, 5)
        .frame(height: 250)
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView()
            .environmentObject(LocalSearchService())
            .environmentObject(LandmarkManager())
    }
}
