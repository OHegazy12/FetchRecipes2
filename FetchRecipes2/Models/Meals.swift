//
//  Meals.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/7/24.
//

import Foundation

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct MealsResponse: Codable {
    let meals: [Meal]
}
