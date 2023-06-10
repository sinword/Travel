//
//  TravelApp.swift
//  Travel
//
//  Created by 新翌王 on 2023/6/7.
//
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    return true
  }
}

@main
struct TravelApp: App {
<<<<<<< HEAD
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var localSearchService: LocalSearchService
=======
    init(){
        FirebaseApp.configure()
        /*
        let settings = Firestore.firestore().settings
        settings.host = "localhost:4400"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        
        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
        Storage.storage().useEmulator(withHost: "localhost", port: 9199)
         */
    }
>>>>>>> e90f932badfc746a275abcf1b9fe0d7819ea54e4
    
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
<<<<<<< HEAD
                .environmentObject(LocalSearchService())
                .environmentObject(LandmarkManager())
=======
                .environmentObject(AuthModel())
>>>>>>> e90f932badfc746a275abcf1b9fe0d7819ea54e4
        }
    }
    
}


