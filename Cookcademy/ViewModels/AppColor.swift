//
//  AppColor.swift
//  Cookcademy
//
//  Created by Elliot Hannah III on 3/22/23.
//

import Foundation
import SwiftUI
 
struct AppColor {
  static let background: Color = Color(.sRGB,
                                       red: 228/255,
                                       green: 235/255,
                                       blue: 250/255,
                                       opacity: 1)
  static let foreground: Color = Color(.sRGB,
                                       red: 118/255,
                                       green: 119/255,
                                       blue: 231/255,
                                       opacity: 1)
}

extension Color: RawRepresentable {
    //Converts the String back into a Color object
    public init?(rawValue: String) {
        do {
            
            //converts the rawValue back into type Data
            let encodedData = rawValue.data(using: .utf8)!
            
            //decodes the Data into an array of Doubles representing the red, green, blue, and alpha components
            let components = try JSONDecoder().decode([Double].self, from: encodedData)
            
            //builds a Color out of the components and assigns that Color to the new object being instantiated
            self = Color(red: components[0],
                         green: components[1],
                         blue: components[2],
                         opacity: components[3])
        }
        catch {
            return nil
        }
    }
    
    //Computed property that converts color into a String
    public var rawValue: String {
        
        //Gets the red, green, blue, and alpha components from a Color
        guard let cgFloatComponents = UIColor(self).cgColor.components else {
            return ""
        }
        
        //Converts each components from floats to doubles
        let doubleComponents = cgFloatComponents.map {Double($0)}
        
        do {
            let encodedComponents = try JSONEncoder().encode(doubleComponents)
            return String(data: encodedComponents, encoding: .utf8) ?? ""
        }
        catch {
            return ""
        }
    }
}
