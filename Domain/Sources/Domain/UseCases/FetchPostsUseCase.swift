//
//  FetchPostsUseCase.swift
//  Domain
//
//  Created by Benjamin Mecanović on 05.11.2022..
//

import Foundation

public struct FetchPostsInput: Sendable {
    public let isInitial: Bool
    public let filter: PostFilter
    
    public init(isInitial: Bool, filter: PostFilter) {
        self.isInitial = isInitial
        self.filter = filter
    }
}

public struct FetchPostsUseCase {
    public let execute: (FetchPostsInput) async -> Result<[Post], Error>
}

public extension FetchPostsUseCase {
    static private let key = "happens_at_date"
    static private let calendar = Calendar.current
    static private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static func live(repository: FetchPostsRepository) -> Self {
        .init { input in
            let filters = makeInput(for: input.filter)
            let request = FetchPostsRequest(isInitial: input.isInitial, filters: filters)
            
            return await repository.fetch(request)
        }
    }
    
    static private func makeInput(for type: PostFilter) -> [FilterInput] {
        switch type {
        case .today:
            return makeTodayFilter()
        case .thisMonth:
            return makeThisMonthFilter()
        case .nextMonth:
            return makeNextMonthFilter()
        case .all:
            return makeAllFilter()
        }
    }
    
    static private func makeTodayFilter() -> [FilterInput] {
        let date = Date.now
        let dateString = formatter.string(from: date)
        let input = FilterInput(operator: .equal, key: key, value: dateString)
        return [input]
    }
    
    static private func makeThisMonthFilter() -> [FilterInput] {
        let date = Date.now
        return makeMonthFilter(for: date)
    }
    
    static private func makeNextMonthFilter() -> [FilterInput] {
        let date = Date.now
        guard let dateInNextMonth = Calendar.current.date(byAdding: .month, value: 1, to: date) else { return [] }
        
        return makeMonthFilter(for: dateInNextMonth)
    }
    
    static private func makeMonthFilter(for date: Date) -> [FilterInput] {
        let interval = calendar.dateInterval(of: .month, for: date)
        
        guard let interval else { return [] }
        
        let start = formatter.string(from: interval.start)
        let end = formatter.string(from: interval.end)
        
        let startInput = FilterInput(operator: .greaterThanOrEqual, key: key, value: start)
        let endInput = FilterInput(operator: .lessThanOrEqual, key: key, value: end)
            
        return [startInput, endInput]
    }
    
    // TODO: - Remove this, only for testing purposes
    static private func makeAllFilter() -> [FilterInput] {
        let date = formatter.string(from: Date.now)
        let input = FilterInput(operator: .lessThanOrEqual, key: key, value: date)
        
        return [input]
    }
}
