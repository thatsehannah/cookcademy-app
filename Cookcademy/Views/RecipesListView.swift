//
//  ContentView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/21/23.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeDataViewModel: RecipeDataViewModel
    let category: MainInformation.Category
    
    private let listBackgroundColor = AppColor.background
    private let listForegroundColor = AppColor.foreground
    
    var body: some View {
        List {
            // Recipes go here
            ForEach(recipes) { recipe in
                NavigationLink(
                    destination: {
                        RecipeDetailView(recipe: recipe)
                    },
                    label: {
                        Text(recipe.mainInformation.name)
                    })
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listForegroundColor)
        }
        .navigationTitle(navigationTitle)
    }
}

extension RecipesListView {
    private var recipes: [Recipe] {
        recipeDataViewModel.getRecipes(for: category)
    }
    
    var navigationTitle: String {
        "\(category.rawValue) Recipes"
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(category: .dinner)
                .environmentObject(RecipeDataViewModel())
        }
        
    }
}
