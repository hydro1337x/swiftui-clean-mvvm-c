//
//  HomeFeedStore.swift
//  UI
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import Foundation
import Domain
import Core

@Observable
public final class HomeFeedStore {
    public private(set) var posts: [PostViewModel] = []
    public private(set) var isLoading = false
    public private(set) var filter: PostFilter = .today
    public var showPlaceholder: Bool {
        posts.isEmpty
    }
    
    public var onItemSelection: ((PostViewModel) -> Void)? = { _ in assertionFailure("HomeFeedStore.onItemSelection is not implemented.") }
    public var onRefresh: (() async -> Void)? = { assertionFailure("HomeFeedStore.onRefresh is not implemented.") }
    
    private(set) var initialTask: Task<Void, Error>?
    private(set) var consecutiveTask: Task<Void, Error>?
    
    private let fetchPostsUseCase: any UseCase<FetchPostsInput, [Post]>
    
    public init(
        fetchPostsUseCase: any UseCase<FetchPostsInput, [Post]>
    ) {
        self.fetchPostsUseCase = fetchPostsUseCase
    }
    
    deinit {
        initialTask?.cancel()
        consecutiveTask?.cancel()
    }
    
    public func handleOnItemAppear(_ item: PostViewModel) {
        consecutiveTask?.cancel()
        consecutiveTask = Task { @MainActor in
            guard item.id == posts.last?.id, !isLoading else { return }
            isLoading = true
            let result = await fetchPosts(isInitial: false, filter: filter)
            await handleState(result)
        }
    }
    
    public func handleOnRefresh() async {
        async let fetchPosts = fetchPosts(isInitial: true, filter: filter)
        async let refresh: Void? = onRefresh?()
        let (_, postsResult) = await (refresh, fetchPosts)
        await handleState(postsResult)
    }
    
    public func handleFilterChange(_ filter: PostFilter) {
        self.filter = filter
        initialTask?.cancel()
        initialTask = Task { @MainActor in
            isLoading = true
            let result = await fetchPosts(isInitial: true, filter: filter)
            await handleState(result)
        }
    }
    
    public func handleItemSelection(_ item: PostViewModel) {
        onItemSelection?(item)
    }
    
    @MainActor
    private func handleState(_ result: Result<[PostViewModel], Error>) async {
        switch result {
        case .success(let newPosts):
            isLoading = false
            posts = newPosts
        case .failure:
            isLoading = false
        }
    }
    
    private func fetchPosts(isInitial: Bool, filter: PostFilter) async -> Result<[PostViewModel], Error> {
        let input = FetchPostsInput(isInitial: isInitial, filter: filter)
        let result = await fetchPostsUseCase(input)
        
        switch result {
        case .success(let items):
            let viewModels = ListMapper.map(items, mapper: PostPresenter.map)
            return .success(viewModels)
        case .failure(let error):
            return .failure(error)
        }
    }
}
