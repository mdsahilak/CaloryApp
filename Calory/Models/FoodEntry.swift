//
//  FoodEntry.swift
//  Calory
//
//  Created by Sahil Ak on 07/05/24.
//

import SwiftUI
import SwiftData

@Model
final class FoodEntry: Identifiable {
    @Attribute(.unique) var id: String
    
    var timestamp: Date
    
    @Attribute(.externalStorage) var image: Data?
    
    var name: String
    var calories: Double
    
    var serving: Double
    
    var fat: Double
    var protein: Double
    var carbohydrates: Double
    
    var debugInfo: String {
        return "\(serving)g of \(name) has \(calories) calories. The macros are - protein: \(protein)g, carbs: \(carbohydrates)g & fats: \(fat)g"
    }
    
    init(id: String = UUID().uuidString, timestamp: Date = Date(), food: NutritionInfo) {
        self.id = id
        self.timestamp = timestamp
        self.name = food.name
        
        self.calories = food.calories
        self.serving = food.serving
        
        self.fat = food.fat
        self.protein = food.protein
        self.carbohydrates = food.carbohydrates
    }
}


