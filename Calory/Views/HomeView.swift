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
    @Query private var meals: [FoodEntry]
    
    @State private var showMealBuilder: Bool = false
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(meals) { meal in
                    NavigationLink {
                        VStack {
                            Text(meal.debugInfo)
                        }
                    } label: {
                        Text(meal.name)
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
            .sheet(isPresented: $showMealBuilder, content: {
                AddFood()
            })
        } detail: {
            Text("Please select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
//            let newMeal = MealEntry(type: .breakfast, food: [])
//            modelContext.insert(newMeal)
            showMealBuilder.toggle()
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
        .modelContainer(for: FoodEntry.self, inMemory: true)
}
