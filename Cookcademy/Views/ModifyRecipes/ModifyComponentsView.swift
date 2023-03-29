//
//  ModifyMultipleIngredientsView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/26/23.
//

import SwiftUI

protocol RecipeComponent {
    init()
}

//ModifyIngredientView and ModifyDirectionView will conform to this
//To conform to this protocol, a struct must conform to View and declare an initializer that
//takes in a binding to Component and a closure named createAction that it will execute when
//the user decides to add a new component
protocol ModifyComponentView: View {
    
    //correlates to a specific component, either the ingredients or directions
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView: View {
    @Binding var ingredients: [Ingredient]
    @State private var newIngredient = Ingredient()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            let addIngredientView = ModifyIngredientView(component: $newIngredient) { ingredient in
                ingredients.append(ingredient)
                newIngredient = Ingredient()
            }.navigationTitle("Add Ingredient")
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient", destination: addIngredientView)
                Spacer()
            } else {
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text(ingredient.description)
                    }
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another ingredient", destination: addIngredientView)
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(listBackgroundColor)
                }
                .foregroundColor(listTextColor)
            }
        }
    }
}

struct ModifyMultipleIngredientsView_Previews: PreviewProvider {
    @State static var emptyIngredients = [Ingredient]()
    
    static var previews: some View {
        NavigationView {
            ModifyComponentsView(ingredients: $emptyIngredients)
        }
        
    }
}
