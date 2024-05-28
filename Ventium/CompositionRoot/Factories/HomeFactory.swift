//
//  HomeFactory.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 15.12.2022..
//

import SwiftUI
import UI
import Domain
import Core

// If i need analytics when a useCase has filished/failed i dont need to inject that into stores i would rather make
// a decorator which will do that behavior and inject the decorator as the useCase which the store already expects
// This is also good if we have feature flagging, we can have all the feature flags here in the factory
// we can just feature flag the view and its dependencies and return it as a factory closure eg. let makeView: () -> AnyView
// No need to pass it deep into the Views..

typealias Callback<I, O> = (I) -> O


struct OnErrorUseCaseDecorator<Input, Output>: UseCase {
    let decoratee: any UseCase<Input, Output>
    let onError: @Sendable (Error) -> Void
    
    init(_ decoratee: any UseCase<Input, Output>, onError: @Sendable @escaping (Error) -> Void) {
        self.decoratee = decoratee
        self.onError = onError
    }
    
    func callAsFunction(_ input: Input) async -> Result<Output, Error> {
        let result = await decoratee.callAsFunction(input)
        
        if case .failure(let error) = result {
            onError(error)
        }
        
        return result
    }
}

@MainActor
struct HomeFactory {
    let fetchPostsUseCase: any UseCase<FetchPostsInput, [Post]>
    let fetchStoriesUseCase: any UseCase<FetchStoriesInput, [Story]>
    let channel: Channel
    
    func makeHomeScene() -> HomeSceneStore {
        let homeFeedStore = HomeFeedStore(fetchPostsUseCase: fetchPostsUseCase)
        let storyPagerStore = StoryPagerStore()
        let storyListStore = StoryListStore(
            fetchStoriesUseCase: fetchStoriesUseCase
        )
        let topSheetStore = FilterTopSheetStore()
        
        return HomeSceneStore(
            homeFeedStore: homeFeedStore,
            storyListStore: storyListStore,
            topSheetStore: topSheetStore,
            storyPagerStore: storyPagerStore
        )
    }
    
    func makePostDetailsScene(with viewModel: PostViewModel) -> PostDetailsViewStore {
        return PostDetailsViewStore(
            posterURL: viewModel.posterURL,
            logoURL: viewModel.avatarURL,
            title: viewModel.name,
            description: viewModel.description ?? ""
        )
    }
}
