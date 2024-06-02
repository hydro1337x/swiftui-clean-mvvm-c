//
//  HomeSceneStore.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 17.03.2023..
//

import Combine
import Domain
import Presentation
import Foundation

@MainActor
@Observable
final class HomeSceneStore {
    let homeFeedStore: HomeFeedStore
    let storyListStore: StoryListStore
    let topSheetStore: FilterTopSheetStore
    let storyPagerStore: StoryPagerStore
    
    var onPostTap: ((PostViewModel) -> Void)? = { _ in assertionFailure("HomeSceneStore.onPostTap is not implemented.") }
    var onStoryTap: ((StoryViewModel) -> Void)? = { _ in assertionFailure("HomeSceneStore.onStoryTap is not implemented.") }
    var onStoryPagerDismiss: (() -> Void)? = { assertionFailure("HomeSceneStore.onStoryPagerDismiss is not implemented.") } 
    
    init(
        homeFeedStore: HomeFeedStore,
        storyListStore: StoryListStore,
        topSheetStore: FilterTopSheetStore,
        storyPagerStore: StoryPagerStore
    ) {
        self.homeFeedStore = homeFeedStore
        self.storyListStore = storyListStore
        self.topSheetStore = topSheetStore
        self.storyPagerStore = storyPagerStore
        
        bind()
    }
    
    private func bind() {
        homeFeedStore.onRefresh = { [storyListStore] in
            await storyListStore.handleRefresh()
        }
        
        homeFeedStore.onItemSelection = { [weak self] item in
            self?.onPostTap?(item)
        }
        
        storyListStore.onStoriesFetch = { [weak storyPagerStore] items in
            storyPagerStore?.setItems(items)
        }
        
        storyListStore.onItemTap = { [weak self] item in
            self?.onStoryTap?(item)
            self?.storyPagerStore.selectItem(item)
        }
        
        topSheetStore.onFilterChanged = { [homeFeedStore] filter in
            homeFeedStore.filterChanged(filter)
        }
        
        storyPagerStore.onDragEnded = { [weak self] in
            self?.onStoryPagerDismiss?()
        }
        
        storyPagerStore.onNextItem = { [weak storyPagerStore, weak storyListStore] in
            guard let storyPagerStore else { return }
            storyListStore?.setFocusedItem(storyPagerStore.selectedItem)
        }
        
        storyPagerStore.onPreviousItem = { [weak storyPagerStore, weak storyListStore] in
            guard let storyPagerStore else { return }
            storyListStore?.setFocusedItem(storyPagerStore.selectedItem)
        }
    }
    
    func selectFilterButtonTap() {
        topSheetStore.toggleIsShown()
    }
    
    func onAppear() {
        storyListStore.handleOnAppear()
        topSheetStore.handleInitialFilter()
    }
}
