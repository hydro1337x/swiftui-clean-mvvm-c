//
//  HomeSceneStore.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 17.03.2023..
//

import Domain
import Presentation
import Core
import Foundation

@MainActor
@Observable
final class HomeSceneStore {
    let homeFeedStore: HomeFeedStore
    let storyListStore: StoryListStore
    let topSheetStore: FilterTopSheetStore
    let storyPagerStore: StoryPagerStore
    
    var onPostTap: InputClosure<PostViewModel> = unimplemented()
    var onStoryTap: InputClosure<StoryViewModel> = unimplemented()
    var onStoryPagerDismiss: VoidClosure = unimplemented()
    
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
        
        homeFeedStore.onItemSelected = { [weak self] item in
            self?.onPostTap(item)
        }
        
        storyListStore.onStoriesFetch = { [weak storyPagerStore] items in
            storyPagerStore?.setItems(items)
        }
        
        storyListStore.onItemTap = { [weak self] item in
            self?.onStoryTap(item)
            self?.storyPagerStore.selectItem(item)
        }
        
        topSheetStore.onFilterChanged = { [homeFeedStore] filter in
            homeFeedStore.handleFilterChanged(filter)
        }
        
        storyPagerStore.onDragEnded = { [weak self] in
            self?.onStoryPagerDismiss()
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
