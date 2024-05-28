//
//  ApolloFetchStoriesRepository.swift
//  Data
//
//  Created by Benjamin Mecanović on 04.01.2023..
//

import Foundation
import Domain
import Apollo
import Graph

public struct ApolloFetchStoriesRepository: FetchStoriesRepository {
    private let client: ApolloClientProtocol
    private let queue: DispatchQueue
    private let paginator = Paginator<Story>()
    private let storiesMapper: (StoriesQuery.Data) throws -> PaginatedResponse<Story>
    
    public init(
        client: ApolloClientProtocol,
        queue: DispatchQueue,
        storiesMapper: @escaping (StoriesQuery.Data) throws -> PaginatedResponse<Story>
    ) {
        self.client = client
        self.queue = queue
        self.storiesMapper = storiesMapper
    }
    
    public func fetch(_ request: FetchStoriesInput) async -> Result<[Story], Error> {
        let query = mapRequest()
      
        let result = await client.fetch(
            query: query,
            cachePolicy: .fetchIgnoringCacheCompletely,
            contextIdentifier: nil,
            queue: queue
        )
        
        do {
            let data = try result.get()
            let paginatedResponse = try storiesMapper(data)
            let posts = await paginator.paginate(paginatedResponse)
            return .success(posts)
        } catch {
            return .failure(error)
        }
    }
    
    private func mapRequest() -> StoriesQuery {
        let filter = Graph.FilterInput(key: "type", value: "story")
        
        let input = QueryInput(
            filters: [filter]
        )
        
        return StoriesQuery(query: GraphQLNullable(input))
    }
}
