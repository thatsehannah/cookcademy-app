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
    
    var favoriteRecipes: [Recipe] {
        recipes.filter {$0.isFavorite}
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
    
    func saveRecipes() {
        do {
            let encodedData = try JSONEncoder().encode(recipes) //encodes the recipes to JSON
            try encodedData.write(to: recipesFileURL) //saves them by writing them to the URL in the documents directory
        }
        catch {
            fatalError("An error occurred while saving recipes: \(error)")
        }
    }
    
    func loadRecipes() {
        guard let data = try? Data(contentsOf: recipesFileURL) else { return } //reads the contents of the internal recipes URL
        do {
            let savedRecipes = try JSONDecoder().decode([Recipe].self, from: data) //decodes the data into an array of Recipe
            recipes = savedRecipes
        }
        catch {
            fatalError("An error occured while loading recipes: \(error)")
        }
    }
    
    private var recipesFileURL: URL {
        do {
            let documentsDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return documentsDir.appendingPathComponent("recipeData")
        }
        catch {
            fatalError("An error while getting the url: \(error)")
        }
    }
}
