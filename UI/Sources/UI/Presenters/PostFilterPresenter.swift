//
//  PostFilterPresenter.swift
//  UI
//
//  Created by Benjamin Mecanović on 13.02.2023..
//

import Foundation
import Domain

public enum PostFilterPresenter {
    public static func map(_ input: PostFilter) -> String {
        switch input {
        case .today:
            return "Today"
        case .thisMonth:
            return "This Month"
        case .nextMonth:
            return "Next Month"
        case .all:
            return "All"
        }
    }
}

public extension PostFilter {
    init?(_ presentableValue: String) {
        switch presentableValue {
        case "Today":
            self = .today
        case "This Month":
            self = .thisMonth
        case "Next Month":
            self = .nextMonth
        case "All":
            self = .all
        default:
            return nil
        }
    }
}
