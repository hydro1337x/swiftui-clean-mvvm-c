//
//  FilterOperator.swift
//  Domain
//
//  Created by Benjamin Mecanović on 26.12.2022..
//

import Foundation

public enum FilterOperator {
    case between
    case equal
    case exactContains
    case greaterThan
    case greaterThanOrEqual
    case isNull
    case looseContains
    case lessThan
    case lessThanOrEqual
}
