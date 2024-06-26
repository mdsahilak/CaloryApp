//
//  FoodEntry.swift
//  Calory
//
//  Created by Sahil Ak on 07/05/24.
//

import SwiftUI
import SwiftData

// Persistent data model to store information related user's logged meals
@Model
final class FoodEntry: Identifiable {
    @Attribute(.unique) var id: String
    
    var timestamp: Date
    
    @Attribute(.externalStorage) var imageData: Data?
    
    var name: String
    var calories: Double
    
    var serving: Double
    
    var fat: Double
    var protein: Double
    var carbohydrates: Double
    
    var image: Image {
        if let data = imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
        } else {
            Image(systemName: "photo.circle")
        }
    }
    
    var debugInfo: String {
        return "\(serving)g of \(name) has \(calories) calories. The macros are - protein: \(protein)g, carbs: \(carbohydrates)g & fats: \(fat)g"
    }
    
    init(id: String = UUID().uuidString, timestamp: Date = Date(), food: NutritionInfo) {
        self.id = id
        self.timestamp = timestamp
        self.name = food.name.capitalized
        
        self.calories = food.calories
        self.serving = food.serving
        
        self.fat = food.fat
        self.protein = food.protein
        self.carbohydrates = food.carbohydrates
    }
    
    var macroTotal: Double { protein + carbohydrates + fat }
    var proteinRatio: Double { protein / macroTotal }
    var carbRatio: Double { carbohydrates / macroTotal }
    var fatRatio: Double { fat / macroTotal }
}

extension FoodEntry {
    static func todayPredicate() -> Predicate<FoodEntry> {
        let today: Date = .now
        
        return #Predicate { entry in
            entry.timestamp > today.startOfDay && entry.timestamp < today.endOfDay
        }
    }
    
    static func datePredicate(for date: Date) -> Predicate<FoodEntry> {
        return #Predicate { entry in
            entry.timestamp > date.startOfDay && entry.timestamp < date.endOfDay
        }
    }
}
