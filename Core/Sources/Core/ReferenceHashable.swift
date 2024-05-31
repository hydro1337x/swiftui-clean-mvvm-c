//
//  ReferenceHashable.swift
//  Core
//
//  Created by Benjamin Macanovic on 28.05.2024..
//

import Foundation

public protocol ReferenceHashable: Hashable, AnyObject, Identifiable {}

public extension ReferenceHashable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
