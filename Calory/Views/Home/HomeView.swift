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
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    
    @Query(sort: \FoodEntry.name, order: .reverse) private var meals: [FoodEntry]
    
    @State private var showMealBuilder = false
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                
                RingView(currentValue: 0.7, totalValue: 1.0, lineWidth: 25.0)
                    .frame(width: 250, height: 250, alignment: .center)
                    .padding()
                    .overlay(alignment: .center) {
                        VStack {
                            Text("350")
                                .font(.largeTitle)
                                .bold()
                            
                            Text("/ 500 Calories")
                                .font(.title3)
                        }
                        .padding()
                    }
                
                Divider()
                
                HStack {
                    previousDayButton
                    
                    Spacer()
                    
                    DatePicker("Date:", selection: $vm.currentDate, displayedComponents: [.date])
                        .labelsHidden()
                    
                    Spacer()
                    
                    nextDayButton
                }
                .padding(.horizontal)
                
                List(filteredMeals, id: \.id) { meal in
                    NavigationLink {
                        FoodEditorView(entry: meal)
                    } label: {
                        MealRow(meal: meal)
                    }
                }
                .animation(.easeInOut, value: filteredMeals)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Your Daily Nutrition")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            
                        } label: {
                            Label("Settings", systemImage: "slider.horizontal.3")
                        }

                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: addItem) {
                            Label("Weight", systemImage: "figure.arms.open")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showMealBuilder) {
            AddFoodView() // Ensure you have an AddFood view defined
        }
    }
    
    var filteredMeals: [FoodEntry] {
        meals.filter({ meal in
            Calendar.current.isDate(meal.timestamp, equalTo: vm.currentDate, toGranularity: .day)
        })
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
    
    private var nextDayButton: some View {
        Button(action: {
            let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: vm.currentDate)
            vm.currentDate = nextDate ?? Date()
        }, label: {
            Image(systemName: "arrow.right")
                .padding()
                .frame(width: 44, height: 44, alignment: .center)
        })
        .buttonStyle(TappedButtonStyle())
    }
    
    private var previousDayButton: some View {
        Button(action: {
            let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: vm.currentDate)
            vm.currentDate = previousDate ?? Date()
        }, label: {
            Image(systemName: "arrow.left")
                .padding()
                .frame(width: 44, height: 44, alignment: .center)
        })
        .buttonStyle(TappedButtonStyle())
    }
}

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
