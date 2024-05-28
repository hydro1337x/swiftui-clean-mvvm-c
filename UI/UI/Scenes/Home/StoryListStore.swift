//
//  StoryListStore.swift
//  UI
//
//  Created by Benjamin Mecanović on 14.02.2023..
//

import Foundation
import Domain
import Core

@Observable
public final class StoryListStore {
    public private(set) var stories: [StoryViewModel] = [] {
        didSet {
            if oldValue != stories {
                onStoriesFetch(stories)
            }
        }
    }
    private(set) var focusedItem: StoryViewModel?
    private(set) var isLoading: Bool = false
    
    public var onStoriesFetch: ([StoryViewModel]) -> Void = { _ in assertionFailure("StoryListStore.onStoriesFetch is not implemented.") }
    public var onItemTap: ((StoryViewModel) -> Void)? = { _ in assertionFailure("StoryListStore.onItemTap is not implemented.")}
    
    private let fetchStoriesUseCase: any UseCase<FetchStoriesInput, [Story]>
    
    private(set) var initialTask: Task<Void, Error>?
    private(set) var consecutiveTask: Task<Void, Error>?
    
    public init(
        fetchStoriesUseCase: any UseCase<FetchStoriesInput, [Story]>
    ) {
        self.fetchStoriesUseCase = fetchStoriesUseCase
    }
    
    deinit {
        initialTask?.cancel()
        consecutiveTask?.cancel()
    }
    
    public func setFocusedItem(_ item: StoryViewModel?) {
        guard let item else { return }
        
        focusedItem = item
        handleOnItemAppear(item)
    }
    
    public func handleOnAppear() {
        initialTask?.cancel()
        initialTask = Task { @MainActor in
            isLoading = true
            let result = await fetchStories(isInitial: true)
            await handleState(result)
        }
    }
    
    public func handleOnItemAppear(_ item: StoryViewModel) {
        consecutiveTask?.cancel()
        guard item.id == stories.last?.id, !isLoading else { return }
        
        consecutiveTask = Task { @MainActor in
            isLoading = true
            let result = await fetchStories(isInitial: false)
            await handleState(result)
        }
    }
    
    @MainActor
    public func handleOnRefresh() async {
        let result = await fetchStories(isInitial: true)
        await handleState(result)
        setFocusedItem(stories.first)
    }
    
    func handleItemTap(_ item: StoryViewModel) {
        onItemTap?(item)
    }
    
    @MainActor
    private func handleState(_ result: Result<[StoryViewModel], Error>) async {
        switch result {
        case .success(let items):
            isLoading = false
            stories = items
        case .failure:
            isLoading = false
        }
    }
    
    private func fetchStories(isInitial: Bool) async -> Result<[StoryViewModel], Error> {
        let input = FetchStoriesInput(isInitial: isInitial)
        let result = await fetchStoriesUseCase(input)
        
        switch result {
        case .success(let items):
            let viewModels = ListMapper.map(items, mapper: StoryPresenter.map)
            return .success(viewModels)
        case .failure(let error):
            return .failure(error)
        }
    }
}

