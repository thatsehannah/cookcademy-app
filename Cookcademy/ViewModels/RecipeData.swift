//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/22/23.
//

import Foundation

class RecipeData: ObservableObject {
    //the @Published property wrapper is ued to monitor any changes
    //Here recipes will monitor when Recipe.testRecipes changes
    @Published var recipes = Recipe.testRecipes
}
