//
//  NutritionInfo.swift
//  Calory
//
//  Created by Sahil Ak on 06/05/24.
//

import Foundation

public struct NutritionInfo: Codable {
    var name: String
    var calories: Double
    
    var servingSize: Double
    
    var totalFat: Double
    var saturatedFat: Double
    
    var protein: Double
    
    var sodium: Int
    var potassium: Int
    
    var cholesterol: Int
    var carbohydrates: Double
    
    var fiber: Double
    
    var sugar: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case calories
        case servingSize = "serving_size_g"
        case totalFat = "fat_total_g"
        case saturatedFat = "fat_saturated_g"
        case protein = "protein_g"
        case sodium = "sodium_mg"
        case potassium = "potassium_mg"
        case cholesterol = "cholesterol_mg"
        case carbohydrates = "carbohydrates_total_g"
        case fiber = "fiber_g"
        case sugar = "sugar_g"
    }
    
}
