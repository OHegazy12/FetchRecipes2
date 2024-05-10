//
//  IngredientsStack.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/9/24.
//

import SwiftUI

struct IngredientsRow: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack {
            Text(ingredient.name.capitalized)
                .font(.system(size: 18, weight: .regular,design: .rounded))
                .foregroundColor(.white)
            Spacer()
            Text(ingredient.measurement.capitalized)
                .font(.system(size: 18, weight: .regular,design: .rounded))
                .foregroundColor(.white)
                .padding(.trailing)
        }
    }
}
