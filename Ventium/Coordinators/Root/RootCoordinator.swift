//
//  RootCoordinator.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import SwiftUI
import UI

struct RootCoordinator: View {
    let store: RootCoordinatorStore
    
    var body: some View {
        VStack(spacing: 0) {
            if store.isBannerShown {
                NetworkBanner()
                    .transition(.asymmetric(insertion: .push(from: .top), removal: .push(from: .bottom)))
            }
            scene
                .transition(.opacity.animation(.default))
        }
        .animation(.default, value: store.isBannerShown)
    }
    
    @MainActor
    @ViewBuilder
    var scene: some View {
        switch store.scene {
        case .auth(let store):
            AuthCoordinator(store: store)
        case .tabs(let store):
            TabsCoordinator(store: store)
        }
    }
}
