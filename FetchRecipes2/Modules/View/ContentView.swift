//
//  ContentView.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/7/24.
//

import SwiftUI

struct DessertView: View {
    @State private var dessert: [Meal] = []
    
    let gridItemLayout = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.flexible(), spacing: 10)]
    
    func fetchDessertData() {
        ApiCaller.fetchDesserts { dessert, error in
            if let dessert = dessert?.meals {
                DispatchQueue.main.async {
                    self.dessert = dessert
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 10) {
                    ForEach(dessert, id: \.idMeal) { meal in
                        VStack {
                            AsyncImageView(url: URL(string: meal.strMealThumb))
                                .frame(width: 150, height: 150)
                                .cornerRadius(10)
                                .padding(.bottom, 5)
                            Text(meal.strMeal)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Desserts")
        }
        .onAppear {
            fetchDessertData()
        }
    }
}

struct DessertView_Preview: PreviewProvider {
    static var previews: some View {
        DessertView()
    }
}
