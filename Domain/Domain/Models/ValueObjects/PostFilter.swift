//
//  PostFilter.swift
//  Domain
//
//  Created by Benjamin Mecanović on 26.12.2022..
//

import Foundation

public enum PostFilter: Equatable, Sendable {
    case today
//    case tomorrow
//    case thisWeek
//    case nextWeek
    case thisMonth
    case nextMonth
    case all
}
