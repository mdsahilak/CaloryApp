//
//  FoodEditor.swift
//  Calory
//
//  Created by Muhammad Waseem on 09/05/24.
//

import SwiftUI

struct FoodEditor: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var nutritionInfo: NutritionInfo

    var body: some View {
        VStack {
            // Custom Navigation Bar
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .padding()
                }

                Spacer()
                Text("Nutrition Details")
                    .font(.title)
                    .fontWeight(.bold)

                Spacer()

                Button(action: {
                    // Placeholder for extended menu action
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                        .padding()
                }
            }

            Image("pineapple") // Placeholder image at the top of the screen
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(10)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(nutritionInfo.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(nutritionInfo.serving, specifier: "%.1f")g")
                        .font(.title2)
                        .fontWeight(.bold)
                }

                HStack {
                    Text("Nutritional Value")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(nutritionInfo.calories, specifier: "%.1f") Kcal")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)

                // Nutrition breakdown rows for Protein, Carbs, and Fat
                NutritionRow(label: "Protein", value: nutritionInfo.protein, total: totalNutritionalValue, icon: "leaf.fill", color: .green)
                NutritionRow(label: "Carbs", value: nutritionInfo.carbohydrates, total: totalNutritionalValue, icon: "drop.fill", color: .purple)
                NutritionRow(label: "Fat", value: nutritionInfo.fat, total: totalNutritionalValue, icon: "flame.fill", color: .orange)
            }
            .padding()

            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    // Compute the total nutritional value for progress calculations
    var totalNutritionalValue: Double {
        nutritionInfo.protein + nutritionInfo.carbohydrates + nutritionInfo.fat
    }
}

struct NutritionRow: View {
    var label: String
    var value: Double
    var total: Double
    var icon: String
    var color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 20, height: 20)
                .padding(.trailing)

            VStack(alignment: .leading) {
                HStack {
                    Text(label)
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(percentageOfTotal(value: value, total: total), specifier: "%.1f")%")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                ProgressView(value: value, total: total)
                    .accentColor(color)
            }
        }
        .padding(.vertical, 5)
    }
    
    func percentageOfTotal(value: Double, total: Double) -> Double {
            (value / total) * 100
        }
}

struct ContentViewPreview: View {
    @State private var nutritionInfo: NutritionInfo?

    var body: some View {
        Group {
            if let info = nutritionInfo {
                FoodEditor(nutritionInfo: info)
            } else {
                Text("Loading...")
                    .onAppear {
                        fetchNutritionInfo()
                    }
            }
        }
    }

    private func fetchNutritionInfo() {
        // Simulating async data fetching
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Sample nutrition info data
            let sampleNutritionInfo = NutritionInfo(name: "Sample Food", calories: 200, serving: 100, fat: 10, protein: 20, carbohydrates: 30)
            self.nutritionInfo = sampleNutritionInfo
        }
    }
}
