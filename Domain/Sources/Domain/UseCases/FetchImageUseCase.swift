//
//  FetchImageUseCase.swift
//  Domain
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import Foundation

public struct FetchImageUseCase {
    public let execute: (String) async -> Result<Data, Error>
}

public extension FetchImageUseCase {
    static func live(repository: FetchImageRepository) -> Self {
        .init { url in
            guard let url = URL(string: url) else {
                return .failure(URLError(.badURL))
            }
            
            return await repository.fetch(url)
        }
    }
}
