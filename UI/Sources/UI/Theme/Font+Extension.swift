//
//  Font+Extension.swift
//  Resources
//
//  Created by Benjamin Mecanović on 29.05.2022..
//

import SwiftUI

extension Font {
    public static func monserrat(_ weight: FontWeight, _ size: CGFloat) -> Font {
        return Font.custom(weight.rawValue, size: size)
    }
}
