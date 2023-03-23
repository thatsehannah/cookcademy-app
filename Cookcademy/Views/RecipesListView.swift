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
    private let listBackgroundColor = AppColor.background
    private let listForegroundColor = AppColor.foreground
    
    var body: some View {
        List {
            // Recipes go here
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listForegroundColor)
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
