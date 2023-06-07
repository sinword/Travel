//
//  EditTripView.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI

struct EditTripView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Edit Trip")
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

struct EditTripView_Previews: PreviewProvider {
    static var previews: some View {
        EditTripView()
    }
}
