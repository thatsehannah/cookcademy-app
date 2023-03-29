//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/29/23.
//

import SwiftUI

struct ModifyDirectionView: View {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
    
    @Environment(\.dismiss) private var dismiss
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description)
                .listRowBackground(listBackgroundColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackgroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    dismiss()
                }
                Spacer()
            }.listRowBackground(listBackgroundColor)
        }.foregroundColor(listTextColor)
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
    @State static var emptyDirection = Direction(description: "", isOptional: false)
    static var previews: some View {
        ModifyDirectionView(direction: $emptyDirection) {_ in return}
    }
}
