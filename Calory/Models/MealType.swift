//
//  MealType.swift
//  Calory
//
//  Created by Sahil Ak on 07/05/24.
//

import Foundation

enum MealType: String, Identifiable, CaseIterable, Codable {
    var id: Self { self }
    
    case breakfast, lunch, dinner, snack
}
