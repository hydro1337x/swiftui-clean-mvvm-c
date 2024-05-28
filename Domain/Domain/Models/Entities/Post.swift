//
//  Post.swift
//  Domain
//
//  Created by Benjamin Mecanović on 05.11.2022..
//

import Foundation

public struct Post: Sendable {
    public let id: String
    public let name: String
    public let description: String?
    public let medias: [Media]
    public let location: Location
    public let tags: [Tag]

    public init(id: String, name: String, description: String?, medias: [Media], location: Location, tags: [Tag]) {
        self.id = id
        self.name = name
        self.description = description
        self.medias = medias
        self.location = location
        self.tags = tags
    }
}
