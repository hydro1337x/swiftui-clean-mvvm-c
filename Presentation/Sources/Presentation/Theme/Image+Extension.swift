//
//  Image+Extension.swift
//  Resources
//
//  Created by Benjamin Mecanović on 29.05.2022..
//

import SwiftUI

public extension SwiftUI.Image {
    init(_ image: VEImage) {
        self.init(uiImage: UIImage(image) ?? UIImage())
    }
}
