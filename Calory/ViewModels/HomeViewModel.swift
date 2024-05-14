//
//  HomeViewModel.swift
//  Calory
//
//  Created by Sahil Ak on 13/05/24.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var showCalorieTargetEditor: Bool = false
    @Published var showMealBuilder = false
    @Published var showCharts = false
    
    @Published var path: [FoodEntry] = []
    
    @Published var currentDate: Date = .now
    
    func goBackToPreviousDay() {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
        currentDate = previousDate ?? Date()
    }
    
    func moveToNextDay() {
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
        currentDate = nextDate ?? Date()
    }
    
}
