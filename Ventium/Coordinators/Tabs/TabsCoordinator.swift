//
//  TabsCoordinator.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import SwiftUI
import UI

struct TabsCoordinator: View {
    let store: TabsCoordinatorStore
    
    var body: some View {
        TabView(selection: .bind(store.tab, with: store.handleTabSelected)) {
            Group {
                HomeCoordinator(store: store.homeCoordinatorStore)
                    .tag(Tab.home)
                    .tabItem {
                        Image(.house)
                    }
                
                SearchCoordinator(factory: .init())
                    .tag(Tab.search)
                    .tabItem {
                        Image(.magnifyingGlass)
                    }
                
                NotificationsCoordinator(factory: .init())
                    .tag(Tab.notifications)
                    .tabItem {
                        Image(.bell)
                    }
                
                ProfileCoordinator(factory: .init())
                    .tag(Tab.profile)
                    .tabItem {
                        Image(.person)
                    }
            }
            .overlay(alignment: .bottom, content: makeErrorToastConditionally)
            .toolbar(store.isTabBarHidden ? .hidden : .visible, for: .tabBar)
            .animation(.default, value: store.message)
            .animation(.default, value: store.isTabBarHidden)
            .toolbarBackground(.visible, for: .tabBar) // This fixes tabBar visibility when side menu is dismissed
        }
        .accentColor(Color(.accent))
    }
    
    @ViewBuilder
    func makeErrorToastConditionally() -> some View {
        if let message = store.message {
            Toast(message: message)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                .transaction { transaction in
                    // Explicitly animating change of safeAreaInset with GeometryReader causes wierd flickering
                    // This is a workaround for .animation(.default) which is deprecated
                    transaction.animation = .default
                }
        }
    }
}
