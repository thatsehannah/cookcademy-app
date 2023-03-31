//
//  MainTabView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/30/23.
//

import SwiftUI

struct MainTabView: View {
    //Creates an instance of the RecipeData view model
    //Any updates to the view model will be sent to this view
    //The @StatObject wrapper will update the view when the model changes
    @StateObject var recipeDataViewModel = RecipeDataViewModel()
    
    var body: some View {
        TabView {
            RecipeCategoryGridView()
                .tabItem {
                    Label("Recipes", systemImage: "list.dash")
                }
            NavigationView {
                RecipesListView(viewStyle: .favorites)
            }
            .tabItem{
                Label("Favorites", systemImage: "heart.fill")
            }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .environmentObject(recipeDataViewModel)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
