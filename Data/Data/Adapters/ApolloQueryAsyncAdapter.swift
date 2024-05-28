//
//  ApolloQueryAsyncAdapter.swift
//  Data
//
//  Created by Benjamin Mecanović on 16.01.2023..
//

import Foundation
import Apollo
import ApolloAPI

actor SendableQueryAdapter {
    var state: State = .ready
    
    func fetch<Query: GraphQLQuery>(
        query: Query,
        client: ApolloClientProtocol,
        cachePolicy: CachePolicy,
        contextIdentifier: UUID? = nil,
        queue: DispatchQueue,
        resultHandler: @Sendable @escaping (Result<GraphQLResult<Query.Data>, Error>) -> Void,
        cancellationHandler: @Sendable @escaping () -> Void
    ) {
        if case .cancelled = state {
            resultHandler(.failure(CancellationError()))
            return
        }
        
        let cancellable = client.fetch(query: query, cachePolicy: cachePolicy, contextIdentifier: contextIdentifier, queue: queue, resultHandler: resultHandler)

      state = .executing(cancellable, cancellationHandler)
    }

    func cancel() {
        if case .executing(let task, let onCancel) = state {
            task.cancel()
            onCancel()
        }
        state = .cancelled
    }
}

extension SendableQueryAdapter {
    enum State {
        case ready
        case executing(Apollo.Cancellable, () -> Void)
        case cancelled
    }
}

extension ApolloClientProtocol {
    func tryFetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        contextIdentifier: UUID?,
        queue: DispatchQueue
    ) async throws -> Query.Data {
        let adapter = SendableQueryAdapter()
        
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                Task {
                    await adapter.fetch(
                      query: query,
                      client: self,
                      cachePolicy: cachePolicy,
                      queue: queue,
                      resultHandler: { result in
                        switch result {
                        case .success(let graphQLResult):
                            if let data = graphQLResult.data {
                                continuation.resume(returning: data)
                            } else if let error = graphQLResult.errors?.first {
                                continuation.resume(throwing: error)
                            } else {
                                continuation.resume(throwing: URLError(.badServerResponse))
                            }
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    },
                    cancellationHandler: {
                      continuation.resume(throwing: CancellationError())
                    })
                }
            }
        } onCancel: {
            Task { await adapter.cancel() }
        }
    }
    
    func fetch<Query: GraphQLQuery>(query: Query,
                                    cachePolicy: CachePolicy,
                                    contextIdentifier: UUID?,
                                    queue: DispatchQueue) async -> Result<Query.Data, Error> {
        do {
            let data = try await tryFetch(query: query, cachePolicy: cachePolicy, contextIdentifier: contextIdentifier, queue: queue)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
