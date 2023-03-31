//
//  ContentView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/21/23.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeDataViewModel: RecipeDataViewModel
    let viewStyle: ViewStyle
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            // Recipes go here
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: binding(for: recipe)).environmentObject(recipeDataViewModel))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }
        .navigationTitle(navigationTitle)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    newRecipe = Recipe()
                    newRecipe.mainInformation.category = recipes.first?.mainInformation.category ?? .breakfast
                    isPresenting = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
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
                                    if case .favorites = viewStyle {
                                        newRecipe.isFavorite = true
                                    }
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
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }
    
    private var recipes: [Recipe] {
        switch viewStyle {
        case let .singleCategory(category):
            return recipeDataViewModel.getRecipes(for: category)
        case .favorites:
            return recipeDataViewModel.favoriteRecipes
        }
    }
    
    private var navigationTitle: String {
        switch viewStyle {
        case let .singleCategory(category):
            return "\(category.rawValue) Recipes"
        case .favorites:
            return "Favorite Recipes"
        }
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeDataViewModel.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        return $recipeDataViewModel.recipes[index]
    }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(viewStyle: .singleCategory(.breakfast))
                .environmentObject(RecipeDataViewModel())
        }
        
    }
}
