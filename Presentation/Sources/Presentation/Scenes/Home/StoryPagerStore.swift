//
//  StoryPagerStore.swift
//  UI
//
//  Created by Benjamin Mecanović on 21.02.2023..
//

import Core
import Foundation

@MainActor
@Observable
public final class StoryPagerStore {
    public private(set) var selectedItem: StoryViewModel?
    private var selectedIndex: Int? {
        didSet {
            selectedItem = getItem(for: selectedIndex)
        }
    }
    private var items: [StoryViewModel] = []
    
    public var onNextItem: VoidClosure = unimplemented()
    public var onPreviousItem: VoidClosure = unimplemented()
    public var onDragEnded: VoidClosure = unimplemented()
    
    public init() {}
    
    public func setItems(_ items: [StoryViewModel]) {
        self.items = items
    }
    
    public func selectItem(_ item: StoryViewModel?) {
        let index = items.firstIndex(where: { $0 == item })
        self.selectedIndex = index
    }
    
    public func nextItem() {
        guard let selectedIndex = selectedIndex, selectedIndex < items.count - 1 else { return }
        
        self.selectedIndex = selectedIndex + 1
        
        onNextItem()
    }
    
    public func previousItem() {
        guard let selectedIndex = selectedIndex, selectedIndex > 0 else { return }
        
        self.selectedIndex = selectedIndex - 1
        
        onPreviousItem()
    }
    
    public func dragEnded() {
        selectedIndex = nil
        onDragEnded()
    }
    
    private func getItem(for index: Int?) -> StoryViewModel? {
        guard let index else { return nil }
        
        return items[index]
    }
}
