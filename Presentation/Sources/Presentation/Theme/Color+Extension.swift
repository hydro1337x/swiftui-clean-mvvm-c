//
//  Color+Extension.swift
//  UI
//
//  Created by Benjamin Mecanović on 30.05.2022..
//

import SwiftUI

public extension SwiftUI.Color {
    init(_ color: VEColor) {
        self.init(withHex: color.hex)
    }

    /// Initializer for hexadecimal string color representations
    ///
    /// - Parameters:
    ///     - hex: Hexadecimal string representation of the given color.
    ///     A valid hex should be prefixed with a # symbol and contain exactly six characters.
    ///
    /// - Returns: UIColor, returns Color.clear if invalid hex is passed
    init(withHex hex: String) {
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {

                    red = CGFloat((hexNumber & 0x00ff0000) >> 16)
                    green = CGFloat((hexNumber & 0x0000ff00) >> 8)
                    blue = CGFloat(hexNumber & 0x000000ff)

                    self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
                    return
                }
            }
        }

        self.init(UIColor.clear)
    }
}
