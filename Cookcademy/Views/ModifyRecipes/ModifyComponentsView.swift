//
//  ModifyMultipleIngredientsView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/26/23.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible {
    init()
    static func singularName() -> String
    static func pluralName() -> String
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    static func pluralName() -> String {
        self.singularName() + "s"
    }
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

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
    @Binding var components: [Component]
    @State private var newComponent = Component()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            let addComponentView = DestinationView(component: $newComponent) { component in
                components.append(component)
                newComponent = Component()
            }.navigationTitle("Add \(Component.singularName().capitalized)")
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first \(Component.singularName())", destination: addComponentView)
                Spacer()
            } else {
                List {
                    ForEach(components.indices, id: \.self) { index in
                        let component = components[index]
                        Text(component.description)
                    }
                    .listRowBackground(listBackgroundColor)
                    NavigationLink("Add another \(Component.singularName())", destination: addComponentView)
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(listBackgroundColor)
                }
                .foregroundColor(listTextColor)
            }
        }
    }
}

struct ModifyMultipleIngredientsView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[1]
    @State static var emptyIngredients = [Ingredient]()
    
    static var previews: some View {
        NavigationView {
            ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
        }
        
    }
}
