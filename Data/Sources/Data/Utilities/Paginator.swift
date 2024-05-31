//
//  Paginator.swift
//  Data
//
//  Created by Benjamin Mecanović on 10.11.2022..
//

import Foundation

public actor Paginator<PageType: Sendable> {
    private var hasNext = true
    private var pages: [PageType] = []
    
    public var cursor = 0
    
    public init() {}
    
    public func paginate(_ response: PaginatedResponse<PageType>) -> [PageType] {
        hasNext ? _paginate(response) : pages
    }
    
    public func reset() {
        hasNext = true
        pages = []
        cursor = 0
    }
    
    private func _paginate(_ response: PaginatedResponse<PageType>) -> [PageType] {
        
        cursor += response.page.count
        pages.append(contentsOf: response.page)
        
        if !response.pagination.hasNext {
            hasNext = false
        }
        
        return pages
    }
}
