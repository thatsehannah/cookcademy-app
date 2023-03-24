//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/22/23.
//

import Foundation

class RecipeDataViewModel: ObservableObject {
    //the @Published property wrapper is ued to monitor any changes
    //Here recipes will monitor when Recipe.testRecipes changes
    @Published var recipes = Recipe.testRecipes
    
    func getRecipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for specificRecipe in recipes {
            if specificRecipe.mainInformation.category == category {
                filteredRecipes.append(specificRecipe)
            }
        }
        return filteredRecipes
    }
}
