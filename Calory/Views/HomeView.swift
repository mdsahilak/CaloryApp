//
//  HomeView.swift
//  Calory
//
//  Created by Muhammad Waseem on 09/05/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var meals: [FoodEntry]
    
    @State private var selectedMeal: FoodEntry?
    @State private var showMealBuilder = false  // Correctly reintroduced
    @State private var selectedMealType = "Breakfast"
    let mealTypes = ["Breakfast", "Lunch", "Dinner"]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Meal Type", selection: $selectedMealType) {
                    ForEach(mealTypes, id: \.self) { mealType in
                        Text(mealType).tag(mealType)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List(filteredMeals, id: \.id) { meal in
                    NavigationLink(destination: FoodEditor(nutritionInfo: NutritionInfo(name: meal.name, calories: meal.calories, serving: meal.serving, fat: meal.fat, protein: meal.protein, carbohydrates: meal.carbohydrates))) {
                                            MealRow(meal: meal)
                                            .onTapGesture {
                                                selectedMeal = meal
                                            }
                    }
                }
                .navigationTitle("Daily Nutritions")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showMealBuilder) {
            AddFood() // Ensure you have an AddFood view defined
        }
    }
    
    var filteredMeals: [FoodEntry] {
        meals.filter { $0.mealType == selectedMealType }
    }
    
    private func addItem() {
        showMealBuilder = true
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(meals[index])
            }
        }
    }
}

struct MealRow: View {
    let meal: FoodEntry

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("pineapple") // Placeholder for meal image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(alignment: .leading) {
                    Text(meal.name)
                        .font(.headline)
                    HStack {
                        Image(systemName: "flame.fill") // Fire icon
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
                Button(action: {
                    // Actions for the 3-dot button
                }) {
                    Image(systemName: "ellipsis")
                }
            }
            .padding(.vertical, 10)
            HStack(spacing: 10) { // Add spacing between the nutrient views
                NutrientView(label: "Protein", value: meal.protein, color: .green)
                NutrientView(label: "Carbs", value: meal.carbohydrates, color: .purple)
                NutrientView(label: "Fat", value: meal.fat, color: .orange)
            }
            .padding(.horizontal, 10) // Adds padding on the left and right of the row
        }
    }
}

struct NutrientView: View {
    let label: String
    let value: Double
    let color: Color

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ProgressView(value: value, total: 100) // Assume 100g is max for the demo
                    .progressViewStyle(LinearProgressViewStyle(tint: color))
                    .frame(width: geometry.size.width) // Full width of the section
                Text("\(value, specifier: "%.1f") g \(label)")
                    .font(.caption)
            }
        }
        .frame(height: 30)
    }
}

//#Preview {
//    HomeView()
//        .modelContainer(for: FoodEntry.self, inMemory: true)
//}
