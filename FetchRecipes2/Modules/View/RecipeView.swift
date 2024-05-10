//
//  RecipeView.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/9/24.
//

import SwiftUI

struct RecipeView: View {
    var dessertId: String
    var imageUrl: String
    @State var selectedCategory = "Ingredients"
    @ObservedObject var detailViewModel: RecipeCard
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center) {
                    AsyncImageView(url: URL(string: imageUrl))
                        .frame(width: 300, height: 300)
                        .cornerRadius(10)
                    Text("\(detailViewModel.recipe.name)")
                        .font(.system(size: 24, weight: .medium,design: .rounded))
                        .foregroundColor(.white)
                        .padding(.bottom)
                    
                    PickerView(selectedCategory: $selectedCategory,labels:  ["Ingredients","Instructions"])
                    
                    if selectedCategory == "Instructions" {
                        InstructionsStack(instructions: (detailViewModel.recipe.instructions!))
                    }
                    
                    if selectedCategory == "Ingredients" {
                        IngredientsStack(ingredients: (detailViewModel.recipe.ingredients!))
                    }
                    
                    Spacer()
                }
                .onAppear() {
                    detailViewModel.fetchDetails(id: dessertId)
                }
            }
            .background(Color(hex: 0x1A1E21).edgesIgnoringSafeArea(.all))
        }
    }
}
