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
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
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
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    isPresenting = true
                }, label: {
                    Image(systemName: "plus")
                })
            })
        })
        //.sheet is the modal
        //Remember: toolbars can only be used on NavigationView views (especially if there aren't any in the hierarchy)
        .sheet(isPresented: $isPresenting, content: {
            NavigationView(content: {
                ModifyRecipeView(recipe: $newRecipe)
                    .navigationTitle("Add a New Recipe")
                    .toolbar(content: {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresenting = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            if newRecipe.isValid {
                                Button("Add") {
                                    recipeDataViewModel.add(recipe: newRecipe)
                                    isPresenting = false
                                }
                            }
                        }
                    })
            })
        })
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
            RecipesListView(category: .breakfast)
                .environmentObject(RecipeDataViewModel())
        }
        
    }
}
