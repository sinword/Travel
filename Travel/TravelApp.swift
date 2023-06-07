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
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    // Disable scene rotation
    
}


