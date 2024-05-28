//
//  Media.swift
//  Domain
//
//  Created by Benjamin Mecanović on 03.01.2023..
//

import Foundation

public struct Media {
    public let url: URL
    public let isFavorite: Bool
    
    public init(url: URL, isFavorite: Bool) {
        self.url = url
        self.isFavorite = isFavorite
    }
}
