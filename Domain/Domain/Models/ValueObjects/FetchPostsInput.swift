//
//  FetchPostsInput.swift
//  Domain
//
//  Created by Benjamin Mecanović on 13.11.2022..
//

import Foundation

public struct FetchPostsInput {
    public let isInitial: Bool
    public let filter: PostFilter
    
    public init(isInitial: Bool, filter: PostFilter) {
        self.isInitial = isInitial
        self.filter = filter
    }
}
