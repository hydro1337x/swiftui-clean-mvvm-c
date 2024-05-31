//
//  PostViewModel.swift
//  UI
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import Foundation

public struct PostViewModel: Identifiable, Hashable, Sendable {
    public let id: String
    public let name: String
    public let description: String?
    public let avatarURL: URL
    public let posterStore: AsyncImageViewStore
    public let locationName: String
    public let address: String
    public let tags: [String]
    
    public init(
        id: String,
        name: String,
        description: String?,
        avatarURL: URL,
        posterStore: AsyncImageViewStore,
        locationName: String,
        address: String,
        tags: [String]
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.avatarURL = avatarURL
        self.posterStore = posterStore
        self.locationName = locationName
        self.address = address
        self.tags = tags
    }
}
