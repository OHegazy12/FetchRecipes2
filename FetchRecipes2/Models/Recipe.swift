//
//  Recipe.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/7/24.
//

import Foundation

struct Recipe: Codable, Hashable {
    let strMeal: String
    let strInstructions: [String]?
    let strIngredients: [String:String]?
}

struct RecipeResonse: Codable {
    let recipe: [Recipe]
}
