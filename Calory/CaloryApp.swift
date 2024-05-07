//
//  CaloryApp.swift
//  Calory
//
//  Created by Sahil Ak on 06/05/24.
//

import SwiftUI
import SwiftData

@main
struct CaloryApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self, MealEntry.self
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
                .task {
                    do {
                        let items = try await NutritionService.fetchNutritionInfo(for: "biryani")
                        print(items)
                    } catch {
                        print(error as NSError)
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
