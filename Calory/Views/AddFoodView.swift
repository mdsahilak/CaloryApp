//
//  AddFoodView.swift
//  Calory
//
//  Created by Muhammad Waseem on 09/05/24.
//

import SwiftUI

// UI for adding new food items from the database
struct AddFoodView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText: String = ""
    @State private var foodItems: [NutritionInfo] = []

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar
                    .padding([.leading, .trailing, .top])
                
                List {
                    ForEach(foodItems, id: \.name) { item in
                        Section {
                            FoodItemRow(item: item)
                        }
                    }
                }
                .navigationBarTitle("Search Database", displayMode: .inline)
            }
        }
    }

    func FoodItemRow(item: NutritionInfo) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name.capitalized)
                        .font(.title3)
                        .bold()
                    
                    HStack {
                        Image(systemName: "flame.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 13, height: 13)
                            .foregroundColor(.red)
                        
                        Text("\(item.calories, specifier: "%.1f") kcal - \(item.serving, specifier: "%.1f") g")
                            .font(.subheadline)
                    }
                }
                
                Spacer()
                
                Label("Add", systemImage: "plus.circle.fill")
                    .labelStyle(.iconOnly)
                    .foregroundColor(.accentColor)
                    .font(.title2)
                    .onTapGesture {
                        let entry = FoodEntry(food: item)
                        modelContext.insert(entry)
                        dismiss()
                    }
            }
        }
        .padding()
        .cornerRadius(10)
    }
    
    private var SearchBar: some View {
        HStack {
            TextField("Search food items", text: $searchText)
                .onSubmit {
                    fetchNutritionInfo()
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.primary)
            
            Button(action: {
                fetchNutritionInfo()
            }) {
                Image(systemName: "magnifyingglass")
                    .padding()
                    .frame(width: 44, height: 44, alignment: .center)
            }
            .buttonStyle(TappedButtonStyle())
            .foregroundColor(.accentColor)
            .disabled(searchText.isEmpty)
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
        AddFoodView()
            .modelContainer(for: FoodEntry.self, inMemory: true)
    }
}
