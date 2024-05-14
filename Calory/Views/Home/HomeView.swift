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
    
    @Query(sort: \FoodEntry.timestamp, order: .reverse) private var meals: [FoodEntry]
    
    @State private var showMealBuilder = false
    @State private var path: [FoodEntry] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Divider()
                
                CalorieTargetView()
                
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
                
                List {
                    ForEach(filteredMeals, id: \.id) { meal in
                        Section {
                            NavigationLink(value: meal) {
                                MealRow(meal: meal)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .animation(.linear, value: meals)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Your Daily Nutrition")
                .navigationDestination(for: FoodEntry.self, destination: { entry in
                    FoodEditorView(entry: entry)
                })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            
                        } label: {
                            Label("Settings", systemImage: "slider.horizontal.3")
                        }

                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button {
                                showMealBuilder.toggle()
                            } label: {
                                Label("Search Database", systemImage: "magnifyingglass")
                            }
                            
                            Button {
                                let entry = FoodEntry(food: .placeholder)
                                modelContext.insert(entry)
                                
                                path.append(entry)
                            } label: {
                                Label("Create Custom", systemImage: "applepencil")
                            }
                        } label: {
                            Label("Add TimeWave", systemImage: "plus")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showMealBuilder) {
            AddFoodView()
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
