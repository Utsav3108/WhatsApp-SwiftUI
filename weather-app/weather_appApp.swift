//
//  weather_appApp.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 13/03/26.
//

import SwiftUI
import CoreData

@main
struct weather_appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
