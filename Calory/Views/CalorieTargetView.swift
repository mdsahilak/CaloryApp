//
//  CalorieTargetView.swift
//  Calory
//
//  Created by Sahil Ak on 14/05/24.
//

import SwiftUI
import SwiftData

struct CalorieTargetView: View {
    @AppStorage(Constants.calorieTargetKey) private var calorieTarget: Double = 0.0
    @Query(filter: FoodEntry.todayPredicate()) private var meals: [FoodEntry]
    
    var body: some View {
        RingView(currentValue: caloriesConsumed, totalValue: calorieTarget, lineWidth: 25.0)
            .frame(width: 250, height: 250, alignment: .center)
            .foregroundColor(.primary)
            .padding()
            .overlay(alignment: .center) {
                VStack {
                    Text("\(caloriesConsumed.rounded(), specifier: "%.0f")")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("/ \(calorieTarget.rounded(), specifier: "%.0f") Calories")
                        .font(.title3)
                }
                .padding()
            }
    }
    
    private var caloriesConsumed: Double {
        return meals.reduce(0.0) { partialResult, entry in
            return partialResult + entry.calories
        }
    }
}

#Preview {
    CalorieTargetView()
}
