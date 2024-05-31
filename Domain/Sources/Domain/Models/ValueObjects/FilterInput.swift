//
//  FilterInput.swift
//  Domain
//
//  Created by Benjamin Mecanović on 26.12.2022..
//

import Foundation

public struct FilterInput {
    public let allowNull: Bool?
    public let invert: Bool?
    public let filterOperator: FilterOperator?
    public let key: String
    public let value: String
    
    public init(
        allowNull: Bool? = nil,
        invert: Bool? = nil,
        `operator`: FilterOperator? = nil,
        key: String,
        value: String
    ) {
        self.allowNull = allowNull
        self.invert = invert
        self.filterOperator = `operator`
        self.key = key
        self.value = value
    }
}
