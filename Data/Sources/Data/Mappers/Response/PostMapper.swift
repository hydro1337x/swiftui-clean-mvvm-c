//
//  PostMapper.swift
//  Data
//
//  Created by Benjamin Mecanović on 13.11.2022..
//

import Foundation
import Graph
import Domain

public enum PostMapper {
    public static func map(_ input: PostsQuery.Data.Post_query.Datum, baseURL: String) throws -> Post {
        let mappedMedias = map(input.medias, baseURL: baseURL)
        
        guard let location = input.location else { throw LocationMissingError() }
        
        let mappedLocation = map(location, baseURL: baseURL)
        
        let mappedTags = map(input.tag_assignments)
        
        return Post(id: input.id, name: input.name, description: input.description, medias: mappedMedias, location: mappedLocation, tags: mappedTags)
    }
    
    public static func map(_ input: PostsQuery.Data, baseURL: String) throws -> PaginatedResponse<Post> {
        PaginatedResponse(
            page: try input.post_query.data.map { try map($0, baseURL: baseURL) },
            pagination: Self.map(input.post_query.pagination)
        )
    }
}

extension PostMapper {
    private static func map(_ input: PostsQuery.Data.Post_query.Pagination) -> Pagination {
        Pagination(cursor: input.cursor, hasNext: input.has_next)
    }
    
    private static func map(_ input: PostsQuery.Data.Post_query.Datum.Medias?, baseURL: String) -> [Media] {
        input?.data.compactMap { value -> Media? in
            guard let url = URL(string: baseURL + value.path) else { return nil }
            
            return Media(url: url, isFavorite: value.is_favourite)
        } ?? []
    }
    
    private static func map(_ input: PostsQuery.Data.Post_query.Datum.Location.Medias?, baseURL: String) -> [Media] {
        input?.data.compactMap { value -> Media? in
            guard let url = URL(string: baseURL + value.path) else { return nil }
            
            return Media(url: url, isFavorite: value.is_favourite)
        } ?? []
    }
    
    private static func map(_ input: PostsQuery.Data.Post_query.Datum.Location, baseURL: String) -> Location {
        let medias = map(input.medias, baseURL: baseURL)
        
        return Location(id: input.id, name: input.name, address: input.address, medias: medias)
    }
    
    private static func map(_ input: PostsQuery.Data.Post_query.Datum.Tag_assignments?) -> [Tag] {
        input?.data.compactMap { value -> Tag? in
            guard let name = value.tag?.name else { return nil }
            
            return Tag(name: name)
        } ?? []
    }
}

extension PostMapper {
    struct LocationMissingError: Error {}
}
