//
//  FilterInputMapper.swift
//  Data
//
//  Created by Benjamin Mecanović on 11.02.2023..
//

import Foundation
import Domain
import Graph

enum FilterInputMapper {
    static func map(_ input: Domain.FilterInput) -> Graph.FilterInput {
        var filterOperator: Graph.FilterOperator?
        
        if let filterOp = input.filterOperator {
            filterOperator = FilterOperatorMapper.map(filterOp)
        }
        
        return Graph.FilterInput(
            key: input.key,
            operator: .init(case: filterOperator),
            value: input.value,
            invert: .init(value: input.invert),
            allowNull: .init(value: input.allowNull)
        )
    }
    
    static func map(_ input: Graph.FilterInput) -> Domain.FilterInput {
        var filterOperator: Domain.FilterOperator?
        
        if let graphFilterOperator = input.`operator`.unwrapped?.value {
            filterOperator = FilterOperatorMapper.map(graphFilterOperator)
        }
        
        return Domain.FilterInput(
            allowNull: input.allowNull.unwrapped,
            invert: input.invert.unwrapped,
            operator: filterOperator,
            key: input.key,
            value: input.value
        )
    }
}
