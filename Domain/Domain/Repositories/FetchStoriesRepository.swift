//
//  FetchStoriesRepository.swift
//  Domain
//
//  Created by Benjamin Mecanović on 04.01.2023..
//

import Foundation

// Repos should have separate interfaces for each method but a single repo may implement all the interfaces (This is the case for endpoint based repos, but Apollo might be a bit different, it might be ok to have a single impl for each method)
// Since UseCases should coordinate different repos (apart from deciding if the data comes from cache, remote or memory) repos do not need to share the same base interface like use cases share the UseCase<I, O> interface.
public protocol FetchStoriesRepository: Sendable  {
    func fetch(_ request: FetchStoriesInput) async -> Result<[Story], Error>
}
