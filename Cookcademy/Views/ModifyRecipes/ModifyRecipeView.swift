//
//  ModifyRecipeView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/24/23.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        Button(action: {
            recipe.mainInformation = MainInformation(name: "test", description: "test", author: "test", category: .breakfast)
            recipe.directions = [Direction(description: "test", isOptional: false)]
            recipe.ingredients = [Ingredient(name: "test", quantity: 1.0, unit: .none)]
        }, label: {
            Text("Fill in the recipe with test data")
        })
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe()
    
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
