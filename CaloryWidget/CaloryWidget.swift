//
//  CaloryWidget.swift
//  CaloryWidget
//
//  Created by Sahil Ak on 14/05/24.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date())]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct CaloryWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        CalorieTargetView()
    }
}

struct CaloryWidget: Widget {
    let kind: String = "CaloryWidget"
    
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

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CaloryWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .modelContainer(sharedModelContainer)
                .defaultAppStorage(.group ?? .standard)
        }
        .configurationDisplayName("Daily Calorie Widget")
        .description("Overview of your daily calorie goal.")
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemSmall) {
    CaloryWidget()
} timeline: {
    SimpleEntry(date: .now)
    SimpleEntry(date: .now)
}
