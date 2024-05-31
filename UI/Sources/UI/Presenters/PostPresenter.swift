//
//  PostPresenter.swift
//  UI
//
//  Created by Benjamin Mecanović on 12.12.2022..
//

import Foundation
import Domain

public enum PostPresenter {
    public static func map(_ input: Post) -> PostViewModel {
        return PostViewModel(
            id: input.id,
            name: input.name,
            description: input.description,
            avatarURL: input.location.medias.first(where: { $0.isFavorite })!.url,
            posterURL: input.medias.first(where: { $0.isFavorite })!.url,
            locationName: input.location.name,
            address: input.location.address ?? "",
            tags: input.tags.map { "#\($0.name)" }
        )
    }
}
