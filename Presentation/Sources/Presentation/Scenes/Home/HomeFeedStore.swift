//
//  HomeFeedStore.swift
//  UI
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import Foundation
import Domain
import Core

@MainActor
@Observable
public final class HomeFeedStore {
    public private(set) var posts: [PostViewModel] = []
    public private(set) var isLoading = false
    public private(set) var filter: PostFilter = .today
    public var showPlaceholder: Bool {
        posts.isEmpty
    }
    
    public var onItemSelected: InputClosure<PostViewModel> = unimplemented()
    public var onRefresh: AsyncVoidClosure = unimplemented()
    
    private(set) var initialTask: Task<Void, Error>?
    private(set) var consecutiveTask: Task<Void, Error>?
    
    private let fetchPostsUseCase: FetchPostsUseCase
    private let makeAsyncImageViewStore: (String) -> AsyncImageViewStore
    
    public init(
        fetchPostsUseCase: FetchPostsUseCase,
        makeAsyncImageViewStore: @escaping (String) -> AsyncImageViewStore
    ) {
        self.fetchPostsUseCase = fetchPostsUseCase
        self.makeAsyncImageViewStore = makeAsyncImageViewStore
    }
    
    public func handleItemAppeared(_ item: PostViewModel) {
        consecutiveTask?.cancel()
        consecutiveTask = Task { @MainActor in
            guard item.id == posts.last?.id, !isLoading else { return }
            isLoading = true
            let result = await fetchPosts(isInitial: false, filter: filter)
            await mutateState(result)
        }
    }
    
    public func handleRefresh() async {
        async let fetchPosts = fetchPosts(isInitial: true, filter: filter)
        async let refresh: Void = onRefresh()
        let (_, postsResult) = await (refresh, fetchPosts)
        await mutateState(postsResult)
    }
    
    public func handleFilterChanged(_ filter: PostFilter) {
        self.filter = filter
        initialTask?.cancel()
        initialTask = Task { @MainActor in
            isLoading = true
            let result = await fetchPosts(isInitial: true, filter: filter)
            await mutateState(result)
        }
    }
    
    public func handleItemSelected(_ item: PostViewModel) {
        onItemSelected(item)
    }
    
    public func handleOnDisappear() {
        initialTask?.cancel()
        consecutiveTask?.cancel()
    }
    
    private func mutateState(_ result: Result<[PostViewModel], Error>) async {
        switch result {
        case .success(let newPosts):
            isLoading = false
            posts += newPosts
        case .failure:
            isLoading = false
        }
    }
    
    private func fetchPosts(isInitial: Bool, filter: PostFilter) async -> Result<[PostViewModel], Error> {
        let input = FetchPostsInput(isInitial: isInitial, filter: filter)
        let result = await fetchPostsUseCase.execute(input)
        
        switch result {
        case .success(let items):
            let viewModels = ListMapper.map(items) { post in
                PostPresenter.map(post, makeAsyncImageViewStore: makeAsyncImageViewStore)
            }
            return .success(viewModels)
        case .failure(let error):
            return .failure(error)
        }
    }
}
