//
//  Location.swift
//  Domain
//
//  Created by Benjamin Mecanović on 03.01.2023..
//

import Foundation

public struct Location {
    public let id: String
    public let name: String
    public let address: String?
    public let medias: [Media]
    
    public init(id: String, name: String, address: String?, medias: [Media]) {
        self.id = id
        self.name = name
        self.address = address
        self.medias = medias
    }
}
