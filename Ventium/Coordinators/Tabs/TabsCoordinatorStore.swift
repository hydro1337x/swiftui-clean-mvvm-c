//
//  TabsCoordinatorStore.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 03.01.2023..
//

import Foundation
import UI

enum Tab {
    case home
    case search
    case notifications
    case profile
}

@Observable
final class TabsCoordinatorStore {
    private(set) var tab: Tab
    private(set) var isTabBarHidden = false
    private(set) var message: String?
    let homeCoordinatorStore: HomeCoordinatorStore
    
    var onLogout: (() -> Void)? = { assertionFailure("TabsCoordinatorStore.onLogout is not implemented.") }
    
    var eventsTask: Task<Void, Never>?
    var delayTask: Task<Void, Error>?
    
    private let clock: any Clock<Duration>
    private let events: AsyncStream<TabsCoordinatorEvent>
    
    init(
        tab: Tab,
        homeCoordinatorStore: HomeCoordinatorStore,
        events: AsyncStream<TabsCoordinatorEvent>,
        clock: any Clock<Duration> = ContinuousClock()
    ) {
        self.tab = tab
        self.homeCoordinatorStore = homeCoordinatorStore
        self.events = events
        self.clock = clock
        
        bind()
    }
    
    deinit {
        print("Deinited: \(self)")
    }
    
    func handleTabSelected(_ tab: Tab) {
        self.tab = tab
    }
    
    private func bind() {
        eventsTask = Task { @MainActor in
            for await event in events {
                switch event {
                case .showToast(let newMessage):
                    message = newMessage
                    startToastHidingTimer()
                }
            }
        }
        
        bindHomeCoordinator()
    }
    
    private func bindHomeCoordinator() {
        homeCoordinatorStore.onStoryTap = { [weak self] story in
            self?.isTabBarHidden = true
        }
        
        homeCoordinatorStore.onStoryPagerDismiss = { [weak self] in
            self?.isTabBarHidden = false
        }
        
        homeCoordinatorStore.onRightBarButtonTap = { [weak self] in
            self?.isTabBarHidden = true
        }
        
        homeCoordinatorStore.onPathIsEmptyChange = { [weak self] isEmpty in
            self?.isTabBarHidden = !isEmpty
        }
        
        homeCoordinatorStore.onSideMenuDismiss = { [weak self] in
            self?.isTabBarHidden = false
        }
        
        homeCoordinatorStore.onLogoutTap = { [weak self] in
            self?.onLogout?()
        }
    }
    
    private func startToastHidingTimer() {
        delayTask?.cancel()
        delayTask = Task { @MainActor in
            try await clock.sleep(for: .seconds(3))
            message = nil
        }
    }
}
