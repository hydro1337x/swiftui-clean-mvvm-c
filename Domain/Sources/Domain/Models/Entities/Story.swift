//
//  Story.swift
//  Domain
//
//  Created by Benjamin Mecanović on 04.01.2023..
//

import Foundation

public struct Story: Sendable {
    public let id: String
    public let location: Location
    public let medias: [Media]
    public let expiresAt: Date
    
    public init(id: String, location: Location, medias: [Media], expiresAt: Date) {
        self.id = id
        self.location = location
        self.medias = medias
        self.expiresAt = expiresAt
    }
}
