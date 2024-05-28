//
//  PaginatedResponse.swift
//  Data
//
//  Created by Benjamin Mecanović on 10.11.2022..
//

import Foundation

public struct PaginatedResponse<T> {
    let page: [T]
    let pagination: Pagination

    public init(page: [T], pagination: Pagination) {
        self.page = page
        self.pagination = pagination
    }
}
