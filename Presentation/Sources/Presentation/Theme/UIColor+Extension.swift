//
//  UIColor+Extension.swift
//  UI
//
//  Created by Benjamin Mecanović on 30.05.2022..
//

import UIKit
import SwiftUI

public extension UIColor {
    convenience init(_ color: VEColor) {
        self.init { traits in
            // Change colors based on light/dark theme here
            UIColor(SwiftUI.Color(color))
        }
    }
}
