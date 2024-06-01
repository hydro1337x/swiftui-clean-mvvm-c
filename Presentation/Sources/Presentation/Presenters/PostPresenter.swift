//
//  PostPresenter.swift
//  UI
//
//  Created by Benjamin Mecanović on 12.12.2022..
//

import Foundation
import Domain

public enum PostPresenter {
    public static func map(_ post: Post, makeAsyncImageViewStore: (String) -> AsyncImageViewStore) -> PostViewModel {
        let avatarURL = post.location.medias.first(where: { $0.isFavorite })!.url.absoluteString
        let avatarStore = makeAsyncImageViewStore(avatarURL)
        let posterURL = post.medias.first(where: { $0.isFavorite })!.url.absoluteString
        let posterStore = makeAsyncImageViewStore(posterURL)
        return PostViewModel(
            id: post.id,
            name: post.name,
            description: post.description,
            avatarStore: avatarStore,
            posterStore: posterStore,
            locationName: post.location.name,
            address: post.location.address ?? "",
            tags: post.tags.map { "#\($0.name)" }
        )
    }
}
