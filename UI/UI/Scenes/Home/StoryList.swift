//
//  StoryList.swift
//  UI
//
//  Created by Benjamin Mecanović on 04.01.2023..
//

import SwiftUI

public struct StoryList: View {
    let store: StoryListStore
    
    public init(store: StoryListStore) {
        self.store = store
    }
    
    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(store.stories) { item in
                        StoryThumbnail(
                            backgroundURL: item.backgroundURL,
                            logoURL: item.locationURL,
                            title: item.locationName
                        )
                        .frame(width: 125, height: 175)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.accent), lineWidth: 2)
                        )
                        .onAppear { store.handleOnItemAppear(item) }
                        .onTapGesture {
                            store.handleItemTap(item)
                        }
                        .id(item)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 1)
            }
            .onChange(of: store.focusedItem) { _, newValue in
                guard let item = newValue else { return }
                proxy.scrollTo(item)
            }
        }
    }
}

public struct StoryListActions {
    let onItemAppear: (StoryViewModel) -> Void
    let onItemTap: (StoryViewModel) -> Void
    
    public init(
        onItemAppear: @escaping (StoryViewModel) -> Void,
        onItemTap: @escaping (StoryViewModel) -> Void
    ) {
        self.onItemAppear = onItemAppear
        self.onItemTap = onItemTap
    }
}

//struct StoryList_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryList(state: .init(), actions: .init(onAppear: { }, onItemAppear: { _ in }, onItemTap: { _ in }))
//    }
//}
