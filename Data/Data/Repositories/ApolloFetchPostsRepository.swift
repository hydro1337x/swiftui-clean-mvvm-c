//
//  ApolloFetchPostsRepository.swift
//  Data
//
//  Created by Benjamin Mecanović on 10.11.2022..
//

import Foundation
import Domain
import Apollo
import Graph
import Core

public struct ApolloFetchPostsRepository: FetchPostsRepository {

    private let paginator = Paginator<Post>()
    
    private let client: ApolloClientProtocol
    private let queue: DispatchQueue
    private let postMapper: (PostsQuery.Data) throws -> PaginatedResponse<Post>
    
    public init(
        client: ApolloClientProtocol,
        queue: DispatchQueue,
        postMapper: @escaping (PostsQuery.Data) throws -> PaginatedResponse<Post>
    ) {
        self.client = client
        self.queue = queue
        self.postMapper = postMapper
    }
    
    public func fetch(_ request: FetchPostsRequest) async -> Result<[Post], Error> {
        if request.isInitial {
            paginator.reset()
        }
        
        let query = mapRequest(limit: 10, cursor: paginator.cursor, filters: request.filters)
        
        let result = await client.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely, contextIdentifier: nil, queue: queue)
        
        do {
            let data = try result.get()
            let paginatedResponse = try postMapper(data)
            let posts = paginator.paginate(paginatedResponse)
            return .success(posts)
        } catch {
            return .failure(error)
        }
    }
    
    private func mapRequest(limit: Int, cursor: Int, filters: [Domain.FilterInput]) -> PostsQuery {
        let pagination = PaginationInput(
            cursor: .some(cursor),
            limit: .some(limit)
        )
        
        let filters = filters.map(FilterInputMapper.map)
        
        let input = QueryInput(
            filters: .some(filters),
            pagination: .some(pagination)
        )
        
        return PostsQuery(query: GraphQLNullable(input))
    }
}
