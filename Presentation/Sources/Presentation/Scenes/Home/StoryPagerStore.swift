//
//  StoryPagerStore.swift
//  UI
//
//  Created by Benjamin Mecanović on 21.02.2023..
//

import Foundation

@MainActor
@Observable
public final class StoryPagerStore {
    public private(set) var selectedItem: StoryViewModel?
    private var selectedIndex: Int?
    private var items: [StoryViewModel] = []
    
    public var onNextItem: (() -> Void)? = { assertionFailure() }
    public var onPreviousItem: (() -> Void)? = { assertionFailure() }
    public var onDragEnded: (() -> Void)? = { assertionFailure() }
    
    public init() {}
    
    public func setItems(_ items: [StoryViewModel]) {
        self.items = items
    }
    
    public func selectItem(_ item: StoryViewModel?) {
        if let item, let selectedIndex = items.firstIndex(where: { $0 == item }) {
            self.selectedIndex = selectedIndex
            selectedItem = items[selectedIndex]
        } else {
            selectedItem = nil
        }
    }
    
    public func nextItem() {
        guard let selectedIndex = selectedIndex, selectedIndex < items.count - 1 else { return }
        
        self.selectedIndex = selectedIndex + 1
        selectedItem = getItem(for: selectedIndex)
        
        onNextItem?()
    }
    
    public func previousItem() {
        guard let selectedIndex = selectedIndex, selectedIndex > 0 else { return }
        
        self.selectedIndex = selectedIndex - 1
        selectedItem = getItem(for: selectedIndex)
        
        onPreviousItem?()
    }
    
    public func dragEnded() {
        selectItem(nil)
        onDragEnded?()
    }
    
    private func getItem(for index: Int?) -> StoryViewModel? {
        guard let index else { return nil }
        
        return items[index]
    }
}
