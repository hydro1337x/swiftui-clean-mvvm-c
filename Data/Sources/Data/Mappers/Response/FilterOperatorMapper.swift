//
//  FilterOperatorMapper.swift
//  Data
//
//  Created by Benjamin Mecanović on 11.02.2023..
//

import Foundation
import Graph
import Domain

enum FilterOperatorMapper {
    static func map(_ input: Domain.FilterOperator) -> Graph.FilterOperator {
        switch input {
        case .between:
            return .between
        case .equal:
            return .eq
        case .exactContains:
            return .exactContains
        case .greaterThan:
            return .gt
        case .greaterThanOrEqual:
            return .gte
        case .isNull:
            return .isNull
        case .looseContains:
            return .looseContains
        case .lessThan:
            return .lt
        case .lessThanOrEqual:
            return .lte
        }
    }
    
    static func map(_ input: Graph.FilterOperator) -> Domain.FilterOperator {
        switch input {
        case .eq:
            return .equal
        case .lte:
            return .lessThanOrEqual
        case .lt:
            return .lessThan
        case .gte:
            return .greaterThanOrEqual
        case .gt:
            return .greaterThan
        case .exactContains:
            return .exactContains
        case .looseContains:
            return .looseContains
        case .between:
            return .between
        case .isNull:
            return .isNull
        }
    }
}
