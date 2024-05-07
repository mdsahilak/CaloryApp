//
//  MealEntry.swift
//  Calory
//
//  Created by Sahil Ak on 07/05/24.
//

import SwiftUI
import SwiftData

@Model
final class MealEntry: Identifiable {
    @Attribute(.unique)
    var id: String
    
    var timestamp: Date
    var type: MealType
    
    var food: [NutritionInfo]
    
    init(id: String = UUID().uuidString, timestamp: Date = Date(), type: MealType, food: [NutritionInfo]) {
        self.id = id
        
        self.timestamp = timestamp
        self.type = type
        
        self.food = food
    }
}


