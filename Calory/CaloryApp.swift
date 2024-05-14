//
//  CaloryApp.swift
//  Calory
//
//  Created by Sahil Ak on 06/05/24.
//

import SwiftUI
import SwiftData
import WidgetKit

@main
struct CaloryApp: App {
    @Environment(\.scenePhase) var phase
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FoodEntry.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .defaultAppStorage(.group ?? .standard)
        }
        .modelContainer(sharedModelContainer)
        .onChange(of: phase) { _, newPhase in
            if newPhase == .background {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}
