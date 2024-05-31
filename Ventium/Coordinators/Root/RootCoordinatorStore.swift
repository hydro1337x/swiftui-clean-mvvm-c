//
//  RootCoordinatorStore.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 03.01.2023..
//

import Foundation
import Presentation

@MainActor
@Observable
final class RootCoordinatorStore {
    enum Scene {
        case tabs(TabsCoordinatorStore)
        case auth(AuthCoordinatorStore)
    }
    
    private(set) var scene: Scene
    private(set) var isBannerShown = false
    
    private let factory: RootFactory
    private let reachabilityStream: AsyncStream<Bool>
    
    var reachabilityTask: Task<Void, Never>?
    
    init(
        scene: Scene,
        factory: RootFactory,
        reachabilityStream: AsyncStream<Bool>
    ) {
        self.scene = scene
        self.factory = factory
        self.reachabilityStream = reachabilityStream
        
        bind()
    }
    
    private func bind() {
        reachabilityTask = Task { @MainActor in
            for await isReachable in reachabilityStream {
                self.isBannerShown = !isReachable
            }
        }
        
        initialBind()
    }
    
    private func initialBind() {
        switch scene {
        case .tabs(let store):
            bindTabsCoordinator(store)
        case .auth(let store):
            bindAuthCoordinator(store)
        }
    }
    
    private func showTabs() {
        let coordinator = factory.makeTabsCoordinator()
        scene = .tabs(coordinator)
        
        bindTabsCoordinator(coordinator)
    }
    
    private func bindTabsCoordinator(_ store: TabsCoordinatorStore) {
        store.onLogout = { [weak self] in
            self?.showAuth()
        }
    }
    
    private func showAuth() {
        let coordinator = factory.makeAuthCoordinator()
        scene = .auth(coordinator)
        
        bindAuthCoordinator(coordinator)
    }
    
    private func bindAuthCoordinator(_ store: AuthCoordinatorStore) {
        store.onLogout = { [weak self] in
            self?.showTabs()
        }
    }
}
