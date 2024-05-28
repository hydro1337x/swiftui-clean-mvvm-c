//
//  HomeCoordinatorEvent.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 25.02.2023..
//

import Foundation
import UI

enum HomeCoordinatorEvent: Channelable {
    case details(PostViewModel)
    case showNavigationBar
    case hideNavigationBar
    case showNavigationBarBackground
    case hideNavigationBarBackground
    case showNavigationTitle(String)
    case hideNavigationTitle
}
