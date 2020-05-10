//
//  SchemeManager.swift
//  one hundred pixels
//
//  Created by Anton Shpakovsky on 10.05.2020.
//  Copyright © 2020 Anton Shpakovsky. All rights reserved.
//

import Foundation
import SwiftUI

struct ColorScheme {
    var backgroundGradient: Gradient
    var primaryColor: Color
    var secondaryColor: Color
    var primaryTextColor: Color
    var secondaryTextColor: Color
}

enum ColorSchemeNames:String {
    case dark, light, mint, summer, spring
}

class SchemeManager: ObservableObject {
    
    @Published var scheme:ColorScheme
    @Published var schemeName:ColorSchemeNames
    
    private let schemeKey = "colorScheme"
    
    let schemes:[ColorSchemeNames:ColorScheme] = [
        .dark: ColorScheme(
            backgroundGradient : Gradient(colors: [Color.init(hex: "133c55"), Color.init(hex: "386fa4")]),
            primaryColor: Color.init(hex: "84d2f6"),
            secondaryColor : Color.init(hex: "84d2f6"),
            primaryTextColor : Color.init(hex: "212121"),
            secondaryTextColor : Color.init(hex: "ffffff")
        ),
        .light: ColorScheme(
            backgroundGradient : Gradient(colors: [Color.init(hex: "59a5d8"), Color.init(hex: "84d2f6")]),
            primaryColor: Color.init(hex: "133c55"),
            secondaryColor : Color.init(hex: "133c55"),
            primaryTextColor : Color.init(hex: "ffffff"),
            secondaryTextColor : Color.init(hex: "212121")
        ),
        .mint: ColorScheme(
            backgroundGradient : Gradient(colors: [Color.init(hex: "93e1d8"), Color.init(hex: "f9ada0")]),
            primaryColor: Color.init(hex: "f9627d"),
            secondaryColor : Color.init(hex: "f9627d"),
            primaryTextColor : Color.init(hex: "212121"),
            secondaryTextColor : Color.init(hex: "212121")
        ),
        .spring: ColorScheme(
            backgroundGradient : Gradient(colors: [Color.init(hex: "7bdff2"), Color.init(hex: "ffc6ff")]),
            primaryColor: Color.init(hex: "ffd6e0"),
            secondaryColor : Color.init(hex: "ffd6e0"),
            primaryTextColor : Color.init(hex: "212121"),
            secondaryTextColor : Color.init(hex: "212121")
        ),
        .summer: ColorScheme(
            backgroundGradient : Gradient(colors: [Color.init(hex: "00c49a"), Color.init(hex: "ffc2b4")]),
            primaryColor: Color.init(hex: "f8e16c"),
            secondaryColor : Color.init(hex: "f8e16c"),
            primaryTextColor : Color.init(hex: "212121"),
            secondaryTextColor : Color.init(hex: "212121")
        ),
    ]
    
    init() {
        let defaults = UserDefaults.standard
        let restoredSchemeName = ColorSchemeNames.init(rawValue: defaults.string(forKey: schemeKey) ?? "light") ?? .light
        self.scheme = schemes[restoredSchemeName]!
        self.schemeName = restoredSchemeName
        useScheme(schemeName)
    }
    
    func useScheme(_ schemeName:ColorSchemeNames) {
        if let scheme = schemes[schemeName] {
            self.scheme = scheme
            self.schemeName = schemeName
        } else {
            self.scheme = schemes[.light]!
            self.schemeName = .light
        }
        saveScheme()
    }
    
    private func saveScheme() {
        let defaults = UserDefaults.standard
        defaults.set(self.schemeName.rawValue, forKey: self.schemeKey)
    }
    
}
