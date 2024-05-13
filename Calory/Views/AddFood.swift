//
//  AddFood.swift
//  Calory
//
//  Created by Muhammad Waseem on 09/05/24.
//

import SwiftUI

struct AddFood: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText: String = ""
    @State private var foodItems: [NutritionInfo] = []

    var body: some View {
        NavigationView {
            VStack {
                SearchBar.padding([.leading, .trailing, .top])
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(foodItems, id: \.name) { item in
                            FoodItemRow(item: item)
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationBarTitle("Add Food", displayMode: .inline)
            }
        }
    }

    func FoodItemRow(item: NutritionInfo) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    HStack {
                        Image(systemName: "flame.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12) // Resize to make the icon smaller
                            .foregroundColor(.red)
                        Text("\(item.calories, specifier: "%.1f") kcal - \(item.serving, specifier: "%.1f") G")
                            .font(.subheadline)
                    }
                }
                .padding(.leading, 10) 
                
                Spacer()
                
                Button(action: {
                    let entry = FoodEntry(food: item)
                    modelContext.insert(entry)
                    dismiss()
                }) {
                    Text("Add")
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            
            HStack {
                NutrientView(label: "Protein", value: item.protein, color: .green)
                NutrientView(label: "Carbs", value: item.carbohydrates, color: .purple)
                NutrientView(label: "Fat", value: item.fat, color: .orange)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    private var SearchBar: some View {
        HStack {
            TextField("Search food items", text: $searchText)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.primary)
            
            Button(action: {
                fetchNutritionInfo()
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.accentColor)
            }
            .padding(.trailing, 10)
        }
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

struct AddFood_Previews: PreviewProvider {
    static var previews: some View {
        AddFood()
            .modelContainer(for: FoodEntry.self, inMemory: true)
    }
}
