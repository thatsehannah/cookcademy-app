//
//  ContentView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/21/23.
//

import SwiftUI

struct RecipesListView: View {
    //Creates an instance of the RecipeData view model
    //Any updates to the view model will be sent to this view
    //The @StatObject wrapper will update the view when the model changes
    @StateObject var recipeData = RecipeData()
    
    var body: some View {
        List {
            // Recipes go here
            ForEach(recipes) { recipe in
                Text(recipe.mainInformation.name)
            }
        }
        .navigationTitle(navigationTitle)
    }
}

extension RecipesListView {
    var recipes: [Recipe] {
        recipeData.recipes
    }
    
    var navigationTitle: String {
        "All Recipes"
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView()
        }
        
    }
}
