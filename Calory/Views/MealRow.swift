//
//  MealRow.swift
//  Calory
//
//  Created by Sahil Ak on 14/05/24.
//

import SwiftUI

struct MealRow: View {
    let meal: FoodEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                meal.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.primary)
                    .clipShape(Circle())
                    .frame(width: 50, alignment: .center)
                    
                
                VStack(alignment: .leading) {
                    Text(meal.name)
                        .font(.headline)
                    HStack {
                        Image(systemName: "flame.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.red)
                        Text("\(meal.calories, specifier: "%.1f") kcal - \(meal.serving, specifier: "%.1f") G")
                            .font(.subheadline)
                    }
                }
                .padding(.leading, 10)
                
                Spacer()
            }
            .padding(.vertical, 10)
            
            HStack(spacing: 10) { // Add spacing between the nutrient views
                MacroBarView(label: "Protein", value: meal.protein, ratio: meal.proteinRatio, color: .green)
                MacroBarView(label: "Carbs", value: meal.carbohydrates, ratio: meal.carbRatio, color: .yellow)
                MacroBarView(label: "Fat", value: meal.fat, ratio: meal.fatRatio, color: .purple)
            }
            .padding(.horizontal, 10) // Adds padding on the left and right of the row
        }
    }
}

struct MacroBarView: View {
    let label: String
    let value: Double
    let ratio: Double
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ProgressView(value: ratio)
                    .progressViewStyle(LinearProgressViewStyle(tint: color))
                    .frame(width: geometry.size.width)
                
                Text("\(value, specifier: "%.0f")g \(label)")
                    .font(.caption)
            }
        }
        .frame(height: 30)
    }
}
