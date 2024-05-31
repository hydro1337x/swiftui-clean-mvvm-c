//
//  UIImage+Extension.swift
//  Resources
//
//  Created by Benjamin Mecanović on 29.05.2022..
//

import UIKit

public extension UIImage {
    convenience init?(_ image: VEImage) {
        self.init(named: image.rawValue, in: .module, with: nil)
    }
}
