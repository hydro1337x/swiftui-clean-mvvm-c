//
//  HomeScene.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 15.12.2022..
//

import SwiftUI
import UI

struct HomeScene: View {
    let store: HomeSceneStore
    
    var angle: CGFloat {
        store.topSheetStore.isShown ? .zero : .pi
    }
    
    var body: some View {
        mainContent
            .overlay(content: makeStoryPagerConditionally)
            .toolbar(content: makeToolbarItem)
            .onFirstAppear(perform: store.onAppear)
    }
    
    private var mainContent: some View {
        ZStack {
            HomeFeed(
                store: store.homeFeedStore,
                storyList: {
                    StoryList(
                        store: store.storyListStore
                    )
                }
            )
            
            TopSheet(
                isShown: store.topSheetStore.isShown,
                items: store.topSheetStore.filters,
                actions: .init(
                    onItemSelection: store.topSheetStore.handleOnFilterSelection,
                    onBackgroundTap: store.topSheetStore.handleOnBackgroundTap,
                    onDragEnded: store.topSheetStore.handleOnDragEnded
                )
            )
        }
    }
    
    func makeStoryPagerConditionally() -> some View {
        Group {
            if store.storyPagerStore.selectedItem != nil {
                StoryPager(store: store.storyPagerStore)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .transition(.opacity)
        .animation(.default, value: store.storyPagerStore.selectedItem)
    }
    
    @MainActor
    func makeToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Button(action: store.selectFilterButtonTap) {
                HStack {
                    Text(store.topSheetStore.selectedFilter)
                        .font(.monserrat(.medium, 16))
                        .foregroundColor(.white)
                    Image(systemName: "chevron.up")
                        .foregroundColor(.white)
                        .rotationEffect(.radians(angle))
                        .animation(.default, value: store.topSheetStore.isShown)
                }
                .frame(height: 26)
                .padding(.horizontal, 10)
                .background(Color(.accent))
                .cornerRadius(13)
                .animation(.default, value: store.topSheetStore.selectedFilter)
            }
        }
    }
}


