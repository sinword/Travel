//
//  NewTripView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI

struct NewTripView: View {
    @State private var name = ""
    @State var showDetail = false
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("New Trip")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.leading, 35)
                Spacer()
            }
            .padding(.top, 30)
            
            VStack(alignment: .leading) {
                Text("Trip Name")
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .padding(.leading, 35)
                    
                TextField("Placeholder", text: $name, prompt: Text("Trip Name"))
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(5)
                    .padding(.leading, 35)
                    .padding(.top, -5)
            }
            .padding(.top, 1)
            
            VStack(alignment: .leading) {
                Text("Destination")
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .padding(.leading, 35)
                    .padding(.top, 20)
                
                TextField("Placeholder", text: $name, prompt: Text("Trip Name"))
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                    .textFieldStyle(.roundedBorder)
                    // .background(.gray)
                    .cornerRadius(5)
                    .padding(.leading, 35)
                    .padding(.top, -5)
            }
            .padding(.top, -5)
            
            
            Spacer()
        }
    }
//    var mapButtonView: some View {
//        Button(action : {
//            showDetail = true
//        }) {
//            Image(
//        }
//    }
//    var mapButtonView: some View {
//        Button(action: {
//            showDetail = true
//        }) {
//            HStack {
//                Image(systemName: "plus")
//                    .font(.system(size: 60))
//                    .fontWeight(.bold)
//                    .foregroundColor(.black)
//                
//                Text("New Trip")
//                    .font(.system(size: 30))
//                    .foregroundColor(.black)
//                    .padding(.leading, 10)
//            }
//        }
//        .frame(width: UIScreen.main.bounds.width * 0.8, height: 105)
//        .background(HomeView.lemonGreen)
//        .cornerRadius(15)
//        .shadow(radius: 3, x: 0, y: 2)
//        
//        NavigationLink(destination: NewTripView(), isActive: $showDetail) {
//            EmptyView()
//        }
//    }
}

struct NewTripView_Previews: PreviewProvider {
    static var previews: some View {
        NewTripView()
    }
}
