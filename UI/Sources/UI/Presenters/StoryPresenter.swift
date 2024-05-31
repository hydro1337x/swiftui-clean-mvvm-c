//
//  StoryPresenter.swift
//  UI
//
//  Created by Benjamin Mecanović on 14.02.2023..
//

import Foundation
import Domain

public enum StoryPresenter {
    public static func map(_ input: Story) -> StoryViewModel {
        let mockURL = URL(string: "localhost:3000")!
        let locationURL = input.location.medias.first(where: \.isFavorite)?.url ?? mockURL
        let backgroundURL = input.medias.first(where: \.isFavorite)?.url ?? mockURL
        
        return StoryViewModel(
            id: input.id,
            backgroundURL: backgroundURL,
            locationName: input.location.name,
            locationURL: locationURL
        )
    }
}
