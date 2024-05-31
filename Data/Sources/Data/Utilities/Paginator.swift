//
//  Paginator.swift
//  Data
//
//  Created by Benjamin Mecanović on 10.11.2022..
//

import Foundation

public actor Paginator<PageType: Sendable> {
    private var hasNext = true
    
    public var cursor = 0
    
    public init() {}
    
    public func paginate(_ response: PaginatedResponse<PageType>) -> [PageType] {
        guard hasNext else { return [] }
        
        cursor += response.page.count
        
        if !response.pagination.hasNext {
            hasNext = false
        }
        
        return response.page
    }
    
    public func reset() {
        hasNext = true
        cursor = 0
    }
}
