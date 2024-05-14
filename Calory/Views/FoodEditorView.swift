//
//  FoodEditorView.swift
//  Calory
//
//  Created by Muhammad Waseem on 09/05/24.
//

import SwiftUI
import PhotosUI

struct FoodEditorView: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var entry: FoodEntry
    
    @State private var pickerItem: PhotosPickerItem?

    var body: some View {
        VStack {
            ScrollView {
                PhotosPicker(selection: $pickerItem, matching: .images) {
                    entry.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.primary)
                        .clipShape(Circle())
                        .frame(maxHeight: 330, alignment: .center)
                        .padding()
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        TextField("Food Title", text: $entry.name)
                            .textFieldStyle(.roundedBorder)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack {
                            TextField("Size", value: $entry.serving, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .frame(width: 70)
                            
                            Text("g")
                        }
                        .font(.headline)
                        .foregroundColor(.gray)
                    }
                    
                    Divider()
                    
                    VStack {
                        proteinField
                        carbsField
                        fatsField
                    }
                    .animation(.easeInOut, value: entry)
                    
                    Divider()
                    
                    HStack {
                        Text("Total Calories (kcal)")
                            .font(.headline)
                        
                        Spacer()
                        
                        HStack {
                            TextField("Size", value: $entry.calories, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                                .frame(width: 70)
                            
                            Text("c")
                        }
                        .font(.headline)
                        .foregroundColor(.gray)
                    }
                    
                    Divider()
                    
                }
                .padding()
            }

            Spacer()
        }
        .navigationTitle("Edit Food")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Label("Dismiss Keyboard", systemImage: "keyboard.chevron.compact.down.fill")
                        .labelStyle(.iconOnly)
                }
            }
        }
        .onChange(of: pickerItem) {
            Task {
                if let loadedImageData = try? await pickerItem?.loadTransferable(type: Data.self) {
                    withAnimation(.easeInOut) {
                        entry.imageData = loadedImageData
                    }
                } else {
                    print("Failed")
                }
            }
        }
    }

    // Compute the total nutritional value for progress calculations
    var totalNutritionalValue: Double {
        entry.protein + entry.carbohydrates + entry.fat
    }
    
    private var proteinField: some View {
        VStack {
            HStack {
                Image(systemName: "dumbbell.fill")
                    .foregroundColor(.green)
                    .frame(width: 20, height: 20)
                    .padding(.trailing)
                
                Text("Protein")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                TextField("Protein", value: $entry.protein, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .frame(width: 70)
                
                Text("g")
            }
            .font(.headline)
            .foregroundColor(.gray)
            
            ProgressView(value: entry.proteinRatio)
                .accentColor(.green)
        }
    }
    
    private var carbsField: some View {
        VStack {
            HStack {
                Image(systemName: "water.waves")
                    .foregroundColor(.yellow)
                    .frame(width: 20, height: 20)
                    .padding(.trailing)
                
                Text("Carbohydrates")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                TextField("Carbohydrates", value: $entry.carbohydrates, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .frame(width: 70)
                
                Text("g")
            }
            .font(.headline)
            .foregroundColor(.gray)
            
            ProgressView(value: entry.carbRatio)
                .accentColor(.yellow)
        }
    }
    
    private var fatsField: some View {
        VStack {
            HStack {
                Image(systemName: "circle.hexagongrid")
                    .foregroundColor(.purple)
                    .frame(width: 20, height: 20)
                    .padding(.trailing)
                
                Text("Fat")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                TextField("Fat", value: $entry.fat, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .frame(width: 70)
                
                Text("g")
            }
            .font(.headline)
            .foregroundColor(.gray)
            
            ProgressView(value: entry.fatRatio)
                .accentColor(.purple)
        }
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
