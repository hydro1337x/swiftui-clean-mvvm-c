//
//  FiltersTopSheetStore.swift
//  UI
//
//  Created by Benjamin Mecanović on 25.01.2023..
//

import Foundation
import Domain

@Observable
public class FilterTopSheetStore {
    public private(set) var isShown = false
    public private(set) var selectedFilter = ""
    public var filters: [String] {
        _filters
            .map(PostFilterPresenter.map)
            .filter { $0 != selectedFilter }
    }
    private let _filters: [PostFilter] = [.today, .thisMonth, .nextMonth, .all]
    
    public var onFilterChanged: (PostFilter) -> Void = { _ in assertionFailure("FilterTopSheetStore.onFilterChangeHandler is not implemented.") }
    
    public init() {}
    
    public func toggleIsShown() {
        isShown.toggle()
    }
    
    public func handleOnBackgroundTap() {
        guard isShown else { return }
        
        isShown.toggle()
    }
    
    public func handleOnDragEnded() {
        isShown.toggle()
    }
    
    public func handleOnFilterSelection(_ filter: String) {
        selectedFilter = filter
        isShown = false
        
        if let filter = PostFilter(filter) {
            onFilterChanged(filter)
        }
    }
    
    public func handleInitialFilter() {
        guard let filter = _filters.first(where: { $0 == .all }) else { return }
        selectedFilter = PostFilterPresenter.map(filter)
        onFilterChanged(filter)
    }
}
