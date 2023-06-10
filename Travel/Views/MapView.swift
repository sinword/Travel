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
    @EnvironmentObject var designatedLandmark: LandmarkManager
    @Environment (\.colorScheme) var colorScheme
    @Environment (\.presentationMode) var presentationMode
    @State private var search: String = ""
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(Color(.systemGray3))
                    TextField("Search", text: $search)
                        .onSubmit {
                            localSearchService.search(query: search)
                        }
                        .onTapGesture {
                            self.isEditing = true
                            hideKeyboard()
                        }
                    
                    if search != "" {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(.systemGray2))
                            .onTapGesture {
                                withAnimation {
                                    self.search = ""
                                }
                            }
                    }
                    
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.vertical, 10)
                                
                Button(action: {
                    if designatedLandmark.isEdit {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 25))
                }
                .disabled(!designatedLandmark.isEdit)
                .padding(.leading, 15)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            // List of map search result
            if localSearchService.landmarks.isEmpty {
                Text("Delicious places awaits you!")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 2)
                    )
                    .padding(.top, 10)
            }
            else {
                LandmarkListView()
            }
            // Map
            Map(coordinateRegion: $localSearchService.region, showsUserLocation: true, annotationItems: localSearchService.landmarks) { landmark in
                MapAnnotation(coordinate: landmark.coordinate) {
                    Image(systemName: "mappin")
                        .foregroundColor(localSearchService.landmark == landmark ? .red: .gray)
                        .scaleEffect(localSearchService.landmark == landmark ? 2: 1)
                }
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .padding(.top, 10)
        // .navigationBarHidden(true)
    }
    
    var bachgoruldColor: Color {
        if colorScheme == .dark {
            return Color(.systemGray5)
        }
        else {
            return Color(.systemGray6)
        }
    }
    
}

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(LocalSearchService())
            .environmentObject(LandmarkManager())
    }
}

