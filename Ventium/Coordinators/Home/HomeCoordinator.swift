//
//  HomeCoordinator.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import SwiftUI
import UI

struct HomeCoordinator: View {
    let store: HomeCoordinatorStore
    
    var body: some View {
        NavigationStack(path: .bind(store.path, with: store.handlePathChange)) {
            Group {
                HomeScene(store: store.rootScene)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(
                        for: HomeCoordinatorStore.Path.self,
                        destination: makeNavigationDestination
                    )
                    .rotation3DEffect(store.isSideMenuVisible ? .degrees(-90) : .zero, axis: (x: 0.0, y: 1.0, z: 0.0), anchor: .leading)
                    .scaleEffect(store.isSideMenuVisible ? .init(0.5) : .init(1), anchor: .leading)
                    .opacity(store.isSideMenuVisible ? 0 : 1)
                    .overlay(alignment: .trailing, content: makeSideMenuConditionally)
                    .animation(.default, value: store.isSideMenuVisible)
            }
            .toolbar(content: makeRightBarButton)
            .toolbar(store.isNavigationBarVisible ? .hidden : .visible, for: .navigationBar)
            .animation(.default, value: store.isNavigationBarVisible)
        }
    }
    
    @ViewBuilder
    func makeSideMenuConditionally() -> some View {
        if store.isSideMenuVisible {
            SideMenu(actions: .init(
                onLogoutTap: store.handleLogoutTap,
                onDismissTap: store.handleSideMenuDismiss)
            )
            .transition(.asymmetric(insertion: .push(from: .trailing), removal: .push(from: .leading)))
            .opacity(store.isSideMenuVisible ? 1 : 0)
        }
    }
    
    func makeNavigationDestination(with path: HomeCoordinatorStore.Path) -> some View {
        Group {
            switch path {
            case .details(let store):
                PostDetailsView(store: store)
            }
        }
        .toolbarBackground(store.isNavigationBarBackgroundVisible ? .visible : .hidden, for: .navigationBar)
        .toolbar(content: makeTitle)
        .animation(.default, value: store.isNavigationBarBackgroundVisible)
    }
    
    func makeTitle() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(store.title)
                .font(.monserrat(.medium, 16))
                .foregroundColor(Color(.accent))
                .opacity(store.isNavigationTitleVisible ? 1 : 0)
                .offset(y: store.isNavigationTitleVisible ? 0 : 15)
                .animation(.default, value: store.isNavigationTitleVisible)
        }
    }
    
    func makeRightBarButton() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: store.handleRightBarButtonTap) {
                Image(systemName: "line.3.horizontal")
                    .fontWeight(.bold)
                    .foregroundColor(Color(.accent))
                    .frame(width: 44, height: 44)
            }
        }
    }
}
