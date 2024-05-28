//
//  Bundle+Extension.swift
//  Resources
//
//  Created by Benjamin Mecanović on 29.05.2022..
//

import Foundation

private class BundleLocator {}

extension Bundle {
    static var framework: Bundle {
        .init(for: BundleLocator.self)
    }
}
