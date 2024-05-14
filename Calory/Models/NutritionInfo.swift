//
//  NutritionInfo.swift
//  Calory
//
//  Created by Sahil Ak on 06/05/24.
//

import Foundation

// Data to be used by Codable to decode JSON from Nutrition API
struct NutritionInfo: Identifiable, Codable {
    static let placeholder = Self(name: "", calories: 0.0, serving: 0.0, fat: 0.0, protein: 0.0, carbohydrates: 0.0)
    
    var id: String { name }
    
    var name: String
    var calories: Double
    
    var serving: Double
    
    var fat: Double
    var protein: Double
    var carbohydrates: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case calories
        case serving = "serving_size_g"
        case fat = "fat_total_g"
        case protein = "protein_g"
        case carbohydrates = "carbohydrates_total_g"
    }
    
}
