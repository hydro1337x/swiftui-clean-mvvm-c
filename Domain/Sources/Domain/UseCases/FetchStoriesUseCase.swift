//
//  FetchStoriesUseCase.swift
//  Domain
//
//  Created by Benjamin Mecanović on 04.01.2023..
//

import Foundation

// TODO: - This might be possible in Swift 5.9
public typealias FetchStoriesUseCase = UseCase<FetchStoriesInput, [Story]>

public struct FetchStoriesInput: Sendable {
    public let isInitial: Bool
    
    public init(isInitial: Bool) {
        self.isInitial = isInitial
    }
}

public struct ConcreteFetchStoriesUseCase: UseCase {
    private let repository: FetchStoriesRepository
    
    public init(repository: FetchStoriesRepository) {
        self.repository = repository
    }
    
    public func callAsFunction(_ input: FetchStoriesInput) async -> Result<[Story], Error> {
        await repository.fetch(input)
    }
}

public struct FetchStoriesUseCaseLoggingDecorator: UseCase {
    private let decoratee: any UseCase<FetchStoriesInput, [Story]>
    
    public init(decoratee: any UseCase<FetchStoriesInput, [Story]>) {
        self.decoratee = decoratee
    }
    
    public func callAsFunction(_ input: FetchStoriesInput) async -> Result<[Story], Error> {
        print("LOGGED")
        return await decoratee.callAsFunction(input)
    }
}
