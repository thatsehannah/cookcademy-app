//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/26/23.
//

import SwiftUI

struct ModifyMainInformationView: View {
    private let listBackground = AppColor.background
    private let listTextColor = AppColor.foreground
    
    @Binding var mainInformation: MainInformation
    
    var body: some View {
        Form {
            TextField("Name", text: $mainInformation.name)
                .listRowBackground(listBackground)
            TextField("Author", text: $mainInformation.author)
                .listRowBackground(listBackground)
            Section(header: Text("Description")) {
                TextEditor(text: $mainInformation.description)
                    .listRowBackground(listBackground)
            }
            Picker(selection: $mainInformation.category, label: HStack {
                    Text("Category")
                    Spacer()
//                    Text(mainInformation.category.rawValue)
            }) {
                ForEach(MainInformation.Category.allCases, id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .listRowBackground(listBackground)
        }
        .foregroundColor(listTextColor)
    }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    @State static var mainInformation = MainInformation(name: "Test Name",
                                                        description: "Test Description",
                                                        author: "Mr. Test",
                                                        category: .dinner)
    @State static var emptyInformation = MainInformation(name: "",
                                                         description: "",
                                                         author: "",
                                                         category: .breakfast)
    
    static var previews: some View {
        ModifyMainInformationView(mainInformation: $mainInformation)
        ModifyMainInformationView(mainInformation: $emptyInformation)
    }
}
