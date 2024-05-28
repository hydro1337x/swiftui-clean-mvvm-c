//
//  ThemeProvider.swift
//  UI
//
//  Created by Benjamin Mecanović on 29.05.2022..
//

import Foundation
import CoreText

public struct ThemeProvider {
    public init() {}

    public func configure() {
        registerFonts()
    }

    private func registerFonts() {
        FontWeight.allCases.forEach { fontWieght in
            registerFont(fontWieght.rawValue)
        }
    }

    private func registerFont(_ name: String) {
        guard let fontURL = Bundle.framework.url(forResource: name, withExtension: "ttf") else {
            print("No font named \(name).ttf was found in the framework bundle")
            return
        }

        var error: Unmanaged<CFError>?

        CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)
        print(error ?? "Successfully registered font: \(name)")
    }
}
