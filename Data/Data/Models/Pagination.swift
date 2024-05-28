//
//  Pagination.swift
//  Data
//
//  Created by Benjamin Mecanović on 10.11.2022..
//

import Foundation

public struct Pagination {
    let cursor: Int
    let hasNext: Bool
    
    public init(cursor: Int, hasNext: Bool) {
        self.cursor = cursor
        self.hasNext = hasNext
    }
}
