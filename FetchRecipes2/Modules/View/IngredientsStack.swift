//
//  IngredientsStack.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/9/24.
//

import SwiftUI

struct IngredientsStack: View {
    let ingredients: [String:String]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(ingredients.sorted(by: >), id: \.key) { key, value in
                IngredientsRow(ingredient: Ingredient(name: key, measurement: value))
                    .background(Color(hex: 0x22282C))
                    .padding(20)
                Divider().overlay(Color.gray.opacity(0.5))
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color(uiColor: .gray), lineWidth: 1)
        )
        .foregroundColor(Color(uiColor: .tertiaryLabel))
        .background(Color(hex: 0x22282C))
        .padding()
    }
}
