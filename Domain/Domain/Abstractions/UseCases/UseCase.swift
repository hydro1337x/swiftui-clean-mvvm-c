//
//  UseCase.swift
//  Domain
//
//  Created by Benjamin Mecanović on 05.11.2022..
//

import Foundation

/**
 UseCase should inherit each derivative UseCase protocol.

 By having a common protocol for UseCases we can later on define additional behavior which will be available to each UseCase.
 */

public protocol UseCaseStream<Input, Output> {
    associatedtype Input
    associatedtype Output
    
    func callAsFunction(_ input: Input) -> AsyncThrowingStream<Output, Error>
}

public protocol UseCase<Input, Output>: UseCaseStream, Sendable {
    associatedtype Input
    associatedtype Output
    
    func callAsFunction(_ input: Input) async -> Result<Output, Error>
}

public extension UseCase {
    func callAsFunction(_ input: Input) -> AsyncThrowingStream<Output, Error> {
        AsyncThrowingStream {
            let result = await callAsFunction(input)
            return try result.get()
        }
    }
}

public extension UseCase where Input == Void {
    func callAsFunction() async -> Result<Output, Error> {
        await callAsFunction(())
    }
}

public extension UseCase {
    func fallback(_ useCase: any UseCase<Input, Output>) -> any UseCase<Input, Output> {
        FallbackUseCase(primary: self, fallback: useCase)
    }
    
    func retry(count: UInt) -> any UseCase<Input, Output> {
        var useCase: any UseCase<Input, Output> = self
        
        for _ in 0..<count {
            useCase = self.fallback(useCase)
        }
        
        return useCase
    }
}

struct FallbackUseCase<Input, Output>: UseCase {
    let primary: any UseCase<Input, Output>
    let fallback: any UseCase<Input, Output>
    
    func callAsFunction(_ input: Input) async -> Result<Output, Error> {
        let result = await primary.callAsFunction(input)
        
        switch result {
        case .success:
            return result
        case .failure(let error):
            if error is CancellationError {
                return result
            }
            return await fallback.callAsFunction(input)
        }
    }
}
