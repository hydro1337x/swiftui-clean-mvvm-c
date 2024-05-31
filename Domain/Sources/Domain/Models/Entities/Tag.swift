//
//  Tag.swift
//  Domain
//
//  Created by Benjamin Mecanović on 04.01.2023..
//

import Foundation

public struct Tag: Sendable {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
