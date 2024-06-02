//
//  FetchStoriesUseCase.swift
//  Domain
//
//  Created by Benjamin Mecanović on 04.01.2023..
//

import Foundation

public struct FetchStoriesInput: Sendable {
    public let isInitial: Bool
    
    public init(isInitial: Bool) {
        self.isInitial = isInitial
    }
}

public struct FetchStoriesUseCase {
    public let execute: (FetchStoriesInput) async -> Result<[Story], Error>
}

public extension FetchStoriesUseCase {
    static func live(repository: FetchStoriesRepository) -> Self {
        .init { input in
            await repository.fetch(input)
        }
    }
}

public extension FetchStoriesUseCase {
    func loggable() -> Self {
        .init { input in
            print("LOGGED BEFORE")
            return await self.execute(input)
        }
    }
}
