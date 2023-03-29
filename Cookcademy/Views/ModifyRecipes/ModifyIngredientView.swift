//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/26/23.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
    @Binding var ingredient: Ingredient
    let createAction: (Ingredient) -> Void
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._ingredient = component
        self.createAction = createAction
    }
    
    @Environment(\.dismiss) private var dismiss
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            Form {
                TextField("Ingredient Name", text: $ingredient.name)
                    .listRowBackground(listBackgroundColor)
                Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                    HStack {
                        Text("Quantity: ")
                        TextField("Quantity",
                                  value: $ingredient.quantity,
                                  formatter: NumberFormatter.decimal)
                            .keyboardType(.numbersAndPunctuation)
                    }
                }
                    .listRowBackground(listBackgroundColor)
                Picker(selection: $ingredient.unit, label: HStack {
                    Text("Unit")
                    Spacer()
                }) {
                    ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .listRowBackground(listBackgroundColor)
                HStack {
                    Spacer()
                    Button("Save") {
                        createAction(ingredient)
                        dismiss()
                    }
                    Spacer()
                }
                .listRowBackground(listBackgroundColor)
            }
            .foregroundColor(listTextColor)
        }
    }
}

struct ModifyIngredientView_Previews: PreviewProvider {
    @State static var emptyIngredient = Ingredient(name: "", quantity: 1.0, unit: .none)
    static var previews: some View {
        NavigationView {
            ModifyIngredientView(component: $emptyIngredient) {_ in return}
        }
       
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}
