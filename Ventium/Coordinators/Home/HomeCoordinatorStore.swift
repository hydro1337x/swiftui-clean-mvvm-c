//
//  HomeCoordinatorStore.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 03.01.2023..
//

import Foundation
import Domain
import Presentation
import Core

@MainActor
@Observable
final class HomeCoordinatorStore {
    enum Path: Hashable {
        case details(PostDetailsViewStore)
    }
    
    private(set) var rootScene: HomeSceneStore
    private(set) var path: [Path] = [] {
        didSet {
            if oldValue != path {
                handleEmptyPath()
            }
        }
    }
    private(set) var isNavigationBarVisible = false
    private(set) var isNavigationBarBackgroundVisible = false
    private(set) var isSideMenuVisible = false
    private(set) var title: String = ""
    private(set) var isNavigationTitleVisible = false
    
    var onStoryTap: (StoryViewModel) -> Void = unimplemented()
    var onStoryPagerDismiss: () -> Void = unimplemented()
    var onRightBarButtonTap: () -> Void = unimplemented()
    var onPathIsEmptyChange: (Bool) -> Void = unimplemented()
    var onLogoutTap: () -> Void = unimplemented()
    var onSideMenuDismiss: () -> Void = unimplemented()
    
    private let factory: HomeFactory
    
    private var eventsTask: Task<Void, Never>?
    
    init(factory: HomeFactory) {
        self.factory = factory
        self.rootScene = factory.makeHomeScene()
        
        bind()
    }
    
    deinit {
        print("Deinited: \(self)")
    }
    
    func bind() {
        rootScene.onPostTap = { [weak self] post in
            self?.showPostDetails(with: post)
        }
        
        rootScene.onStoryTap = { [weak self] story in
            self?.setNavigationBarHidden(true)
            self?.onStoryTap(story)
        }
        
        rootScene.onStoryPagerDismiss = { [weak self] in
            self?.setNavigationBarHidden(false)
            self?.onStoryPagerDismiss()
        }
    }
    
    func handlePathChange(_ path: [Path]) {
        self.path = path
    }
    
    func handleRightBarButtonTap() {
        toggleIsSideMenuShown()
        setNavigationBarHidden(true)
        onRightBarButtonTap()
    }
    
    func handleLogoutTap() {
        onLogoutTap()
    }
    
    func handleSideMenuDismiss() {
        toggleIsSideMenuShown()
        setNavigationBarHidden(false)
        onSideMenuDismiss()
    }
    
    private func setNavigationBarBackgroundHidden(_ value: Bool) {
        self.isNavigationBarBackgroundVisible = value
    }
    
    private func showPostDetails(with viewModel: PostViewModel) {
        let store = factory.makePostDetailsScene(with: viewModel)
        
        store.onDisappear = { [weak self] in
            self?.isNavigationBarBackgroundVisible = false
            self?.isNavigationTitleVisible = false
        }
        
        store.onHeaderAppear = { [weak self] in
            self?.isNavigationBarBackgroundVisible = false
            self?.isNavigationTitleVisible = false
        }
        
        store.onHeaderDisappear = { [weak self, title = store.title] in
            self?.isNavigationBarBackgroundVisible = true
            self?.showNavigationTitle(title)
        }
        
        path.append(.details(store))
    }
    
    private func showNavigationTitle(_ title: String) {
        self.title = title
        self.isNavigationTitleVisible = true
    }
    
    private func hideNavigationTitle() {
        self.isNavigationTitleVisible = false
    }
    
    private func handleEmptyPath() {
        onPathIsEmptyChange(path.isEmpty)
    }
    
    private func setNavigationBarHidden(_ value: Bool) {
        self.isNavigationBarVisible = value
    }
    
    private func toggleIsSideMenuShown() {
        isSideMenuVisible.toggle()
    }
}

extension PostDetailsViewStore: ReferenceHashable {}
