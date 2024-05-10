//
//  DessertView.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/7/24.
//

import SwiftUI

struct DessertView: View {
    @State private var dessert: [Meal] = []
    @State private var searchDessertText = ""
    @State private var navToRecipe = false
    var detailVM = RecipeCard(networking: Network())
    
    let gridItemLayout = [
        GridItem(.adaptive(minimum: 150)),
        GridItem(.flexible(), spacing: 10)
    ]
    
    func fetchDessertData() {
        ApiCaller.fetchDesserts { result, error in
            if let result = result?.meals {
                DispatchQueue.main.async {
                    self.dessert = result
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
                    ForEach(dessert.filter {
                        searchDessertText.isEmpty ? true : $0.strMeal.localizedCaseInsensitiveContains(searchDessertText)
                    }, id: \.idMeal) { meal in
                        NavigationLink(destination: RecipeView(dessertId: meal.idMeal, imageUrl: meal.strMealThumb, detailViewModel: detailVM)) {
                            VStack {
                                AsyncImageView(url: URL(string: meal.strMealThumb))
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(10)
                                    .padding(.bottom, 5)
                                Text(meal.strMeal)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(uiColor: .label))
                            }
                        }
                    }
                }
                .padding()
                .onTapGesture {
                    navToRecipe.toggle()
                }
            }
            .navigationTitle("Desserts")
        }
        .searchable(text: $searchDessertText, prompt: "Look up desserts 🍰")
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
