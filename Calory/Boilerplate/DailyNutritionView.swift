////
////  DailyNutritionView.swift
////  Calory
////
////  Created by Muhammad Ali on 12/05/2024.
////
//
//import SwiftUI
//
//struct DailyNutritionView: View {
//    @State private var selectedTabIndex = 0
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            // Header
//            HStack {
//                Text("Daily Nutritions")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .padding(.leading)
//                
//                Spacer()
//                
//                Image(systemName: "plus")
//                    .padding(.trailing)
//                
//                Image(systemName: "calendar")
//                    .padding(.trailing)
//            }
//            
//            // Dates Slider
//            DatesSliderView()
//            
//            // Tabs
//            TabView(selection: $selectedTabIndex) {
//                ForEach(0..<3) { index in
//                    VStack {
//                        // Food Items List
//                        ScrollView {
//                            ForEach(0..<5) { _ in
//                                FoodItemView()
//                                    .padding()
//                            }
//                        }
//                        .background(Color.gray.opacity(0.1))
//                        .cornerRadius(10)
//                        
//                        Spacer()
//                    }
//                    .tag(index)
//                }
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//            
//            Spacer()
//        }
//    }
//}
//
//struct DatesSliderView: View {
//    var body: some View {
//        Text("Dates Slider")
//            .padding(.top)
//            // Replace this with your implementation of the dates slider
//            .frame(height: 50)
//    }
//}
//
//struct FoodItemView: View {
//    var body: some View {
//        HStack {
//            // Food Image (Replace with actual image)
//            Image(systemName: "photo")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 80, height: 80)
//                .cornerRadius(8)
//            
//            VStack(alignment: .leading) {
//                // Food Name
//                Text("Food Name")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                
//                // Nutrition Details
//                HStack {
//                    NutritionDetail(name: "Fat", value: 10)
//                    NutritionDetail(name: "Protein", value: 20)
//                    NutritionDetail(name: "Carbs", value: 30)
//                }
//                .padding(.top, 4)
//            }
//            
//            Spacer()
//            
//            // Navigation Dots (Replace with actual navigation dots)
//            Image(systemName: "ellipsis")
//        }
//    }
//}
//
//struct NutritionDetail: View {
//    var name: String
//    var value: Int
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(name)
//                .font(.caption)
//                .foregroundColor(.secondary)
//            
//            Text("\(value)g")
//                .font(.caption)
//                .fontWeight(.bold)
//        }
//        .padding(.trailing)
//    }
//}
//
//struct DailyNutritionView_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyNutritionView()
//    }
//}
