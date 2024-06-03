//
//  HomeFeed.swift
//  UI
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import SwiftUI

public struct HomeFeed: View {
    let store: HomeFeedStore
    let storyList: () -> StoryList
    
    public init(store: HomeFeedStore, storyList: @escaping () -> StoryList) {
        self.store = store
        self.storyList = storyList
    }
    
    @MainActor
    @ViewBuilder
    var background: some View {
        Group {
            if store.showPlaceholder {
                MissingContentView()
            } else {
                EmptyView()
            }
        }
        .animation(.default, value: store.showPlaceholder)
    }

    public var body: some View {
        List {
            Group {
                storyList()
                    .padding(.bottom, 10)
                
                ForEach(store.posts) { item in
                    PostCard(
                        locationName: item.locationName,
                        postName: item.name,
                        posterStore: item.posterStore,
                        avatarStore: item.avatarStore,
                        tags: item.tags
                    )
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                    .onAppear { store.handleItemAppeared(item) }
                    .onTapGesture {
                        store.handleItemSelected(item)
                    }
                }
                
                HStack {
                    if store.isLoading {
                        ProgressView()
                            .tint(Color(.accent))
                            .frame(maxWidth: .infinity)
                            .scaleEffect(1.5)
                            .padding(.bottom, 10)
                    }
                }
            }
            .listRowInsets(EdgeInsets(top: 10, leading: .zero, bottom: .zero, trailing: .zero))
            .listRowSeparator(.hidden)
            .buttonStyle(PlainButtonStyle())
        }
        .scrollContentBackground(.hidden)
        .background(background)
        .listStyle(.plain)
        .refreshable {
            await store.handleRefresh()
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = UIColor(.accent)
        }
        .onDisappear(perform: store.handleOnDisappear)
        .transition(AnyTransition.opacity)
        .animation(.easeInOut, value: store.isLoading)
    }
}

//struct HomeFeed_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            HomeFeed(
//                state: HomeFeedState(),
//                actions: .init(
//                    onItemAppear: { _ in },
//                    onRefresh: {}
//                ),
//                storyList: {
//                    StoryList(
//                        state: .init(),
//                        actions: .init(
//                            onAppear: { },
//                            onItemAppear: { _ in },
//                            onItemTap: { _ in }
//                        ), namespace: <#Namespace.ID#>
//                    )
//                }
//            )
//        }
//        .modifier(OnLoadViewModifier {
//            ThemeProvider().configure()
//        })
//    }
//}
