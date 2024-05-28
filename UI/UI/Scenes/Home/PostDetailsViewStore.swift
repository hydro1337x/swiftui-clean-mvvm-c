//
//  PostDetailsViewStore.swift
//  UI
//
//  Created by Benjamin Macanovic on 26.05.2024..
//

import Foundation

@Observable
public final class PostDetailsViewStore {
    public let title: String
    
    let posterURL: URL
    let logoURL: URL
    let description: String
    let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum commodo tristique felis, vehicula semper tortor volutpat vitae. Suspendisse bibendum nisi at dignissim lacinia. Suspendisse in convallis quam, id viverra urna. Duis non sem suscipit, lobortis sem vel, interdum nibh. Maecenas ullamcorper condimentum lectus, sed accumsan orci dignissim pretium. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices ... "
    
    
    public var onHeaderDisappear: (() -> Void)? = { assertionFailure("PostDetailsViewStore.onHeaderDisappear is not implemented.") }
    public var onHeaderAppear: (() -> Void)? = { assertionFailure("PostDetailsViewStore.onHeaderAppear is not implemented.") }
    public var onDisappear: (() -> Void)? = { assertionFailure("PostDetailsViewStore.onDisappear is not implemented.") }
    
    //    var postDetailsActions: PostDetailsActions {
    //        .init(
    //            onHeaderDisappear: {
    //                self.channel.send(HomeCoordinatorEvent.showNavigationBarBackground)
    //                self.channel.send(HomeCoordinatorEvent.showNavigationTitle(self.title))
    //            },
    //            onHeaderAppear: {
    //                self.channel.send(HomeCoordinatorEvent.hideNavigationBarBackground)
    //                self.channel.send(HomeCoordinatorEvent.hideNavigationTitle)
    //            }, onDisappear: {
    //                self.channel.send(HomeCoordinatorEvent.hideNavigationBarBackground)
    //                self.channel.send(HomeCoordinatorEvent.hideNavigationTitle)
    //            }
    //        )
    //    }
    
    public init(posterURL: URL, logoURL: URL, title: String, description: String) {
        self.posterURL = posterURL
        self.logoURL = logoURL
        self.title = title
        self.description = description
    }
    
    deinit {
        print("Deinit: \(String(describing: self))")
    }
    
    func handleHeaderDisappear() {
        onHeaderDisappear?()
    }
    
    func handleHeaderAppear() {
        onHeaderAppear?()
    }
    
    func handleDisappear() {
        onDisappear?()
    }
}
