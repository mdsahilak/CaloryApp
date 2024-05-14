//
//  ChartsView.swift
//  Calory
//
//  Created by Sahil Ak on 14/05/24.
//

import SwiftUI
import Charts
import SwiftData

struct ChartsView: View {
    @Environment(\.modelContext) private var modelContext
    
    let last7Days: [Date] = {
        let date = Date()
        
        let values = (-6...0).map({ date.equivalentDateOfPreviousDay(count: $0) })
        return values
    }()
    
    @State private var calories: [TimeInterval] = Array(repeating: 0.0, count: 7)
    
    var totalCalories: TimeInterval { calories.reduce(0.0, +) }
    
    var body: some View {
        NavigationStack {
            Chart {
                ForEach(0..<7, id: \.self) { i in
                    LineMark(
                        x: .value("Day", last7Days[i].shortDayName),
                        y: .value("Calories", calories[i])
                    )
                    
                    PointMark(
                        x: .value("Day", last7Days[i].shortDayName),
                        y: .value("Calories", calories[i])
                    )
                }
            }
            .chartYAxisLabel("Last 7 Days (Calories)", position: .top, alignment: .center)
            .chartYAxis(.hidden)
            .frame(minHeight: 130)
            .padding(.vertical)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Weekly Progress Chart")
        }
        .onAppear {
            loadCalories()
        }
    }
    
    func loadCalories() {
        for (i, day) in Array(zip(last7Days.indices, last7Days)) {
            let caloriesConsumed = calculateTotalCaloriesForDate(date: day)
//            let caloriesConsumed = Double.random(in: 0..<10_000)
            
            withAnimation {
                self.calories[i] = caloriesConsumed
            }
        }
    }
    
    func calculateTotalCaloriesForDate(date: Date) -> Double {
        let fetchDescriptor = FetchDescriptor<FoodEntry>(predicate: FoodEntry.datePredicate(for: date))

        do {
            let entries = try modelContext.fetch(fetchDescriptor)
            let caloriesConsumed = entries.reduce(0.0) { partialResult, entry in
                partialResult + entry.calories
            }
            
            return caloriesConsumed
        } catch {
            print("Failed to load Food Entry model.")
            
            return 0.0
        }
    }
}
