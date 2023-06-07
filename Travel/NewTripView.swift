//
//  NewTripView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI

struct NewTripView: View {
    var body: some View {
        VStack {
            HStack {
                Text("New Trip")
                    .font(Font.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.leading, 35)
                    Spacer()
            }
            .padding(.top, 30)
            Spacer()
        }
        
    }
}

struct NewTripView_Previews: PreviewProvider {
    static var previews: some View {
        NewTripView()
    }
}
