//
//  NewTripView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI
import MapKit
import Firebase
import FirebaseDatabase
import FirebaseDatabaseUI

struct EditTripView: View {
    @EnvironmentObject var tripManager: TripManager
    @EnvironmentObject var designatedTrip: TripModel
    @Environment (\.presentationMode) var presentationMode
    @State private var showMapView = false
    @State private var mapSnapshot: UIImage?
    @State var members = ["John", "Jane", "Alice", "Bob", "Sam", "Michele"]
    
    
//    @State var tripName = ""
//    @StateObject var tripDestination = LandmarkManager()
//    @StateObject var tripTime = TimeManager()
    
        // private let database = Database.database().reference()
    
//    init() {
//        _tripName = State(wrappedValue: designatedTrip.name)
//        _tripDestination = StateObject(wrappedValue: LandmarkManager())
//        _tripTime = StateObject(wrappedValue: TimeManager())
//    }
    
    var body: some View {
        ScrollView {
            VStack() {
                Button(action: {
                    print("DESIGNATEDTRIP INFO")
                    designatedTrip.printInfo()
                }) {
                    Text("printinfo")
                }
                HStack {
                    Text("Edit Trip")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.leading, 35)
                    Spacer()
                }
                .padding(.top, 20)
                
                HStack {
                    Text("Trip Name")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.leading, 40)
                    Spacer()
                }
                .padding(.top, 10)
                
                HStack {
                    Spacer()
                    TextField("Placeholder", text: $designatedTrip.name, prompt: Text("Trip Name"))
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                        .textFieldStyle(.roundedBorder)
                        .cornerRadius(5)
                    Spacer()
                }
                .padding(.top, -10)
                
                HStack {
                    Text("Destination")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.leading, 40)
                    Spacer()
                }
                .padding(.top, 5)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: EditMapView(), isActive: $showMapView) {
                        EmptyView()
                    }
                    Button(action: {
                        self.showMapView = true
                    }) {
                        if let image = mapSnapshot {
                            Image(uiImage: image)
                                .cornerRadius(12)
                                .shadow(radius: 3, x: 0, y: 2)
                        }
                    }
                    .onAppear {
                        captureMapSnapshot()
                        print("UPDATE Snapshot")
                    }
                    Spacer()
                }
                .padding(.top, 5)
                
                HStack {
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Name: \(designatedTrip.destination.landmark.name)")
                        Text("Distance: \(designatedTrip.destination.landmark.formattedDistance) KM")
                        Text("Address: \(designatedTrip.destination.landmark.title)")
                    }
                    .padding(8)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                        )
                    .padding(.top, 10)
                }
                .padding(.top, 15)
                            
                DatePicker("Time", selection: $designatedTrip.time)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .padding(.top, 15)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                
                memberView
                    .padding(.top, 15)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                
                finishButtonView
                    .padding(.top, 15)
            }
            
            Spacer()
        }
    }
        
           
    var memberView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Members")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {
                    addMember()
                }) {
                    Text("Add")
                        .font(.system(size: 18))
                        .fontWeight(.regular)
                        .foregroundColor(.blue)
                        .underline()
                        .padding(.trailing, 2)
                }
            }
            
            ScrollView {
                VStack(spacing: 3) {
                    ForEach(members, id: \.self) { member in
                        HStack {
                            Text("\(member)")
                            Spacer()
                            Button(action: {
                                removeMember(member: member)
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                            }
                            .padding(.trailing, 10)
                            .buttonStyle(PlainButtonStyle())
                            .contentShape(Rectangle())
                            .frame(width: 50, height: 20)
                        }
                        .padding()
                        .background(.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
            }
            .frame(height: 150)
            .padding(.top, 5)
            
        }
        
    }
    
    @State private var showAlert = false

    var finishButtonView: some View {
        HStack {
            Spacer()
            Button(action: {
                // Check each item is filled before saving
                if (designatedTrip.name == "" || designatedTrip.time < Date() || designatedTrip.destination.landmark.name == "") {
                    showAlert = true
                }
                else {
                    tripManager.updateTrip(editedTrip: designatedTrip)
                    tripManager.printInfo()
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                HStack {
                    Spacer()
                    Text("Finish")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: 45)
            .background(HomeView.lemonGreen)
            .cornerRadius(12)
            .shadow(radius: 3, x: 0, y: 2)
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("警告"),
                message: Text("請檢查填寫的項目"),
                dismissButton: .default(Text("確認"))
            )
        }
    }
    
    func showAlert(message: String) -> Alert {
        Alert(title: Text("Alert"), message: Text(message), dismissButton: .default(Text("OK")))
    }
    
    func captureMapSnapshot() {
        let mapView = MKMapView()
        mapView.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        @State var options = MKMapSnapshotter.Options()
        options.mapRect = mapView.visibleMapRect
        options.scale = UIScreen.main.scale
        options.size = CGSize(width: UIScreen.main.bounds.width * 0.8, height: 150)
        
        options.region = designatedTrip.destination.region
        


        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            guard snapshot != nil else {
                print("Error capturing map snapshot:  \(error?.localizedDescription ?? "")")
                return
            }
            
            let mapImage = snapshot?.image
            let finalImage = UIGraphicsImageRenderer(size: options.size).image { context in
                mapImage?.draw(at: .zero)
                let annotation = MKPointAnnotation()
                annotation.coordinate = designatedTrip.destination.landmark.coordinate
                let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
                let pinImage = pinView.image
                let point = snapshot?.point(for: designatedTrip.destination.landmark.coordinate)
                pinImage?.draw(at: point!)
            }
            mapSnapshot = finalImage
        }
    }
    
    func addMember() {
        print("Add member")
    }
    
    func removeMember(member: String) {
        print("Remove member \(member)")
    }
}
    
    
struct EditTripView_Previews: PreviewProvider {
    static var previews: some View {
        NewTripView()
            .environmentObject(TripManager())
            .environmentObject(TripModel())
    }
}
