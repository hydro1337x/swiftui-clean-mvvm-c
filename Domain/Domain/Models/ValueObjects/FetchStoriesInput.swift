//
//  FetchStoriesInput.swift
//  Domain
//
//  Created by Benjamin Mecanović on 04.01.2023..
//

import Foundation

public struct FetchStoriesInput: Sendable {
    public let isInitial: Bool
    
    public init(isInitial: Bool) {
        self.isInitial = isInitial
    }
}
