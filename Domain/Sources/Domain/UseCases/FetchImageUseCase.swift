//
//  FetchImageUseCase.swift
//  Domain
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import Foundation

public typealias FetchImageUseCase = UseCase<String, Data>

public final class ConcreteFetchImageUseCase: UseCase {
    private let repository: FetchImageRepository
    
    public init(repository: FetchImageRepository) {
        self.repository = repository
    }
    
    public func callAsFunction(_ input: String) async -> Result<Data, Error> {
        guard let url = URL(string: input) else {
            return .failure(URLError(.badURL))
        }
        
        return await repository.fetch(url)
    }
}
