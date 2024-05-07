//
//  NutritionInfo.swift
//  Calory
//
//  Created by Sahil Ak on 06/05/24.
//

import Foundation

struct NutritionInfo: Identifiable, Codable {
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
