//
//  FetchPostsRequest.swift
//  Domain
//
//  Created by Benjamin Mecanović on 27.12.2022..
//

import Foundation

public struct FetchPostsRequest {
    public let isInitial: Bool
    public let filters: [FilterInput]
    
    public init(isInitial: Bool, filters: [FilterInput]) {
        self.isInitial = isInitial
        self.filters = filters
    }
}
