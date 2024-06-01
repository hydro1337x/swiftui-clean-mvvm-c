//
//  StoryPresenter.swift
//  UI
//
//  Created by Benjamin Mecanović on 14.02.2023..
//

import Foundation
import Domain

public enum StoryPresenter {
    public static func map(_ story: Story, makeAsyncImageViewStore: (String) -> AsyncImageViewStore) -> StoryViewModel {
        let locationURL = story.location.medias.first(where: \.isFavorite)!.url.absoluteString
        let locationImageStore = makeAsyncImageViewStore(locationURL)
        let backgroundURL = story.medias.first(where: \.isFavorite)!.url.absoluteString
        let backgroundImageStore = makeAsyncImageViewStore(backgroundURL)
        
        return StoryViewModel(
            id: story.id,
            backgroundImageStore: backgroundImageStore,
            locationName: story.location.name,
            locationImageStore: locationImageStore
        )
    }
}
