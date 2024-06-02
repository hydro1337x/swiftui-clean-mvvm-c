//
//  StoryListStore.swift
//  UI
//
//  Created by Benjamin Mecanović on 14.02.2023..
//

import Foundation
import Domain
import Core

@MainActor
@Observable
public final class StoryListStore {
    public private(set) var stories: [StoryViewModel] = [] {
        didSet {
            onStoriesFetch(stories)
        }
    }
    private(set) var focusedItem: StoryViewModel?
    private(set) var isLoading: Bool = false
    
    public var onStoriesFetch: ([StoryViewModel]) -> Void = { _ in assertionFailure("StoryListStore.onStoriesFetch is not implemented.") }
    public var onItemTap: ((StoryViewModel) -> Void)? = { _ in assertionFailure("StoryListStore.onItemTap is not implemented.")}
    
    private let fetchStoriesUseCase: FetchStoriesUseCase
    private let makeAsyncImageViewStore: (String) -> AsyncImageViewStore
    
    private(set) var initialTask: Task<Void, Error>?
    private(set) var consecutiveTask: Task<Void, Error>?
    
    public init(
        fetchStoriesUseCase: FetchStoriesUseCase,
        makeAsyncImageViewStore: @escaping (String) -> AsyncImageViewStore
    ) {
        self.fetchStoriesUseCase = fetchStoriesUseCase
        self.makeAsyncImageViewStore = makeAsyncImageViewStore
    }
    
    public func setFocusedItem(_ item: StoryViewModel?) {
        guard let item else { return }
        
        focusedItem = item
        itemAppeared(item)
    }
    
    public func appear() {
        initialTask?.cancel()
        initialTask = Task { @MainActor in
            isLoading = true
            let result = await fetchStories(isInitial: true)
            await handleState(result)
        }
    }
    
    func disappear() {
        initialTask?.cancel()
        consecutiveTask?.cancel()
    }
    
    public func itemAppeared(_ item: StoryViewModel) {
        consecutiveTask?.cancel()
        guard item.id == stories.last?.id, !isLoading else { return }
        
        consecutiveTask = Task { @MainActor in
            isLoading = true
            let result = await fetchStories(isInitial: false)
            await handleState(result)
        }
    }
    
    @MainActor
    public func refresh() async {
        let result = await fetchStories(isInitial: true)
        await handleState(result)
        setFocusedItem(stories.first)
    }
    
    func itemTapped(_ item: StoryViewModel) {
        onItemTap?(item)
    }
    
    @MainActor
    private func handleState(_ result: Result<[StoryViewModel], Error>) async {
        switch result {
        case .success(let items):
            isLoading = false
            stories += items
        case .failure:
            isLoading = false
        }
    }
    
    private func fetchStories(isInitial: Bool) async -> Result<[StoryViewModel], Error> {
        let input = FetchStoriesInput(isInitial: isInitial)
        let result = await fetchStoriesUseCase.execute(input)
        
        switch result {
        case .success(let items):
            let viewModels = ListMapper.map(items, mapper: { story in
                StoryPresenter.map(story, makeAsyncImageViewStore: makeAsyncImageViewStore)
            })
            return .success(viewModels)
        case .failure(let error):
            return .failure(error)
        }
    }
}

