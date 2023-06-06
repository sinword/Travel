//
//  TravelApp.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//

import SwiftUI

@main
struct TravelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
