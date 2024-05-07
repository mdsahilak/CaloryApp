//
//  HomeView.swift
//  Calory
//
//  Created by Sahil Ak on 06/05/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var meals: [MealEntry]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(meals) { meal in
                    NavigationLink {
                        Text(meal.food.first?.name ?? "-")
                    } label: {
                        Text(meal.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Meals")
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
        } detail: {
            Text("Please select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newMeal = MealEntry(type: .breakfast, food: [])
            modelContext.insert(newMeal)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(meals[index])
            }
        }
    }
}

#Preview {
    HomeView()
}
