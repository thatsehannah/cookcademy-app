//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/22/23.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
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
                    }
                }
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        HStack {
                            Text("\(index + 1). ").bold()
                            Text("\(direction.isOptional ? "(Optional) " : "")"
                                 + "\(direction.description)")
                        }
                        
                    }
                }
            }
            
            .navigationTitle(recipe.mainInformation.name)
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    //used to initialize and dsiplay an actual instance of this view
    @State static var recipe = Recipe.testRecipes[8]
    static var previews: some View {
        //The NavigationView allows the View to show the navigation title (on line 27)
        NavigationView {
            RecipeDetailView(recipe: recipe)
        }
        
    }
}