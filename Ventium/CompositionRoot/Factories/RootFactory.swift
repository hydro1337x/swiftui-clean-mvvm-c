//
//  RootFactory.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 15.12.2022..
//

import SwiftUI
import Presentation

@MainActor
struct RootFactory {
    let authFactory: AuthFactory
    let tabsFactory: TabsFactory
    let channel: Channel
    
    func makeAuthCoordinator() -> AuthCoordinatorStore {
        let loginViewStore = authFactory.makeLoginScene()
        return AuthCoordinatorStore(loginViewStore: loginViewStore)
    }
    
    func makeTabsCoordinator() -> TabsCoordinatorStore {
        let homeCoordinatorStore = tabsFactory.makeHomeCoordinator()
        return TabsCoordinatorStore(
            tab: .home,
            homeCoordinatorStore: homeCoordinatorStore,
            events: channel.getValues()
        )
    }
}
