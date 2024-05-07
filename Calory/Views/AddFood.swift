//
//  AddFood.swift
//  Calory
//
//  Created by Sahil Ak on 07/05/24.
//

import SwiftUI

struct AddFood: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText: String = ""
    @State private var foodItems: [NutritionInfo] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar
                    .padding()
                
                ScrollView(.vertical) {
                    ForEach(foodItems) { item in
                        FoodItemRow(for: item)
                    }
                }
            }
            .navigationTitle("Add Food")
        }
    }
    
    private func FoodItemRow(for item: NutritionInfo) -> some View {
        HStack {
            Text(item.name)
            Button("Add") {
                let entry = FoodEntry(food: item)
                modelContext.insert(entry)
                
                dismiss()
            }
        }
    }
    
    private var SearchBar: some View {
        HStack {
            TextField("Search food items", text: $searchText)
                .onSubmit {
                    fetchNutritionInfo()
                }
                .textFieldStyle(.roundedBorder)
                .keyboardType(.webSearch)
        }
        .font(.body)
        .tint(.accentColor)
        .accessibilityAddTraits(.isSearchField)
    }
    
    private func fetchNutritionInfo() {
        Task {
            do {
                foodItems = try await NutritionService.fetchNutritionInfo(for: searchText)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    AddFood()
        .modelContainer(for: FoodEntry.self, inMemory: true)
}
