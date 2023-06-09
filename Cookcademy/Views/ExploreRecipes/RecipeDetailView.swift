//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/22/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    @EnvironmentObject private var recipeDataViewModel: RecipeDataViewModel
    
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    @State private var isPresenting = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredients.indices, id: \.self) { index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                            .foregroundColor(listTextColor)
                    }
                }.listRowBackground(listBackgroundColor)
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        if direction.isOptional && hideOptionalSteps {
                            EmptyView()
                        } else {
                            HStack {
                                let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                                Text("\(index + 1). ").bold()
                                Text("\(direction.isOptional ? "(Optional) " : "")"
                                     + "\(direction.description)")
                            }.foregroundColor(listTextColor)
                        }                        
                    }
                }.listRowBackground(listBackgroundColor)
            }
        }
        .onDisappear{
            print("RecipeDetailView has been dismissed")
        }
        .navigationTitle(recipe.mainInformation.name)
        .toolbar {
            ToolbarItem {
                HStack {
                    Button("Edit") {
                        isPresenting = true
                    }
                    Button(action: {
                        recipe.isFavorite.toggle()
                    }) {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    }
                }
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $recipe)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresenting = false
                                recipeDataViewModel.saveRecipes()
                            }
                        }
                    }
                    .navigationTitle("Edit Reciple")
            }
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    //used to initialize and dsiplay an actual instance of this view
    @State static var recipe = Recipe.testRecipes[8]
    static var previews: some View {
        //The NavigationView allows the View to show the navigation title (on line 27)
        NavigationView {
            RecipeDetailView(recipe: $recipe)
        }
        
    }
}
