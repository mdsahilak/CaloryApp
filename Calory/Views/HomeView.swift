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
    
    @AppStorage(Constants.calorieTargetKey) private var calorieTarget: Double = 0.0
    
    @Query(sort: \FoodEntry.timestamp, order: .reverse) private var meals: [FoodEntry]
    
    var body: some View {
        NavigationStack(path: $vm.path) {
            VStack {
                Divider()
                
                Button(action: {
                    vm.showCalorieTargetEditor.toggle()
                }, label: {
                    CalorieTargetView()
                })
                    
                
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
                .alert("Daily Calorie Target", isPresented: $vm.showCalorieTargetEditor) {
                    TextField("Enter Target", value: $calorieTarget, format: .number)
                } message: {
                    Text("Please enter the daily amount of calories you want to consume")
                }
                
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
                            vm.showCharts.toggle()
                        } label: {
                            Label("Charts", systemImage: "chart.xyaxis.line")
                        }

                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button {
                                vm.showMealBuilder.toggle()
                            } label: {
                                Label("Search Database", systemImage: "magnifyingglass")
                            }
                            
                            Button {
                                let entry = FoodEntry(food: .placeholder)
                                modelContext.insert(entry)
                                
                                vm.path.append(entry)
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
        .sheet(isPresented: $vm.showCharts, content: {
            ChartsView()
                .presentationDetents([.fraction(0.44)])
        })
        .sheet(isPresented: $vm.showMealBuilder) {
            AddFoodView()
        }
    }
    
    var filteredMeals: [FoodEntry] {
        meals.filter({ meal in
            Calendar.current.isDate(meal.timestamp, equalTo: vm.currentDate, toGranularity: .day)
        })
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(meals[index])
            }
        }
    }
    
    private var previousDayButton: some View {
        Button(action: {
            vm.goBackToPreviousDay()
        }, label: {
            Image(systemName: "arrow.left")
                .padding()
                .frame(width: 44, height: 44, alignment: .center)
        })
        .buttonStyle(TappedButtonStyle())
    }
    
    private var nextDayButton: some View {
        Button(action: {
            vm.moveToNextDay()
        }, label: {
            Image(systemName: "arrow.right")
                .padding()
                .frame(width: 44, height: 44, alignment: .center)
        })
        .buttonStyle(TappedButtonStyle())
    }
}



//#Preview {
//    HomeView()
//        .modelContainer(for: FoodEntry.self, inMemory: true)
//}
