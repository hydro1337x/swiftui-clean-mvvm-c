//
//  UIFont+Extension.swift
//  Resources
//
//  Created by Benjamin Mecanović on 29.05.2022..
//

import UIKit

public extension UIFont {
    static func monserrat(_ weight: FontWeight, _ size: CGFloat) -> UIFont? {
        return UIFont(name: weight.rawValue, size: size)
    }
}
