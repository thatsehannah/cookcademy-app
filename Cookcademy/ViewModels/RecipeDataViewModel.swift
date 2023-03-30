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
    
    func add(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
        }
    }
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        
        return nil
    }
}
