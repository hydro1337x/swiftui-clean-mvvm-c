//
//  StoryMapper.swift
//  Data
//
//  Created by Benjamin Mecanović on 13.02.2023..
//

import Foundation
import Graph
import Domain

public enum StoryMapper {
    public static func map(_ input: StoriesQuery.Data.Post_query.Datum, baseURL: String) throws -> Story {
        let mappedMedias = map(input.medias, baseURL: baseURL)
        
        guard let location = input.location else { throw LocationMissingError() }
        
        let mappedLocation = map(location, baseURL: baseURL)
        
        // TODO: - Create DateMapper
        return Story(id: input.id, location: mappedLocation, medias: mappedMedias, expiresAt: Date())
    }
    
    public static func map(_ input: StoriesQuery.Data, baseURL: String) throws -> PaginatedResponse<Story> {
        PaginatedResponse(
            page: try input.post_query.data.map { try map($0, baseURL: baseURL) },
            pagination: map(input.post_query.pagination)
        )
    }
}

extension StoryMapper {
    private static func map(_ input: StoriesQuery.Data.Post_query.Pagination) -> Pagination {
        Pagination(cursor: input.cursor, hasNext: input.has_next)
    }
    
    private static func map(_ input: StoriesQuery.Data.Post_query.Datum.Medias?, baseURL: String) -> [Media] {
        input?.data.compactMap { value -> Media? in
            guard let url = URL(string: baseURL + value.path) else { return nil }
            
            return Media(url: url, isFavorite: value.is_favourite)
        } ?? []
    }
    
    private static func map(_ input: StoriesQuery.Data.Post_query.Datum.Location.Medias?, baseURL: String) -> [Media] {
        input?.data.compactMap { value -> Media? in
            guard let url = URL(string: baseURL + value.path) else { return nil }
            
            return Media(url: url, isFavorite: value.is_favourite)
        } ?? []
    }
    
    private static func map(_ input: StoriesQuery.Data.Post_query.Datum.Location, baseURL: String) -> Location {
        let medias = map(input.medias, baseURL: baseURL)
        
        return Location(id: input.id, name: input.name, address: input.address, medias: medias)
    }
    
    private static func map(_ input: StoriesQuery.Data.Post_query.Datum.Tag_assignments?) -> [Tag] {
        input?.data.compactMap { value -> Tag? in
            guard let name = value.tag?.name else { return nil }
            
            return Tag(name: name)
        } ?? []
    }
}

extension StoryMapper {
    struct LocationMissingError: Error {}
}
