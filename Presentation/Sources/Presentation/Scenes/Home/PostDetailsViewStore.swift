//
//  PostDetailsViewStore.swift
//  UI
//
//  Created by Benjamin Macanovic on 26.05.2024..
//

import Core
import Foundation

@Observable
public final class PostDetailsViewStore {
    public let title: String
    
    let posterStore: AsyncImageViewStore
    let logoStore: AsyncImageViewStore
    let description: String
    let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum commodo tristique felis, vehicula semper tortor volutpat vitae. Suspendisse bibendum nisi at dignissim lacinia. Suspendisse in convallis quam, id viverra urna. Duis non sem suscipit, lobortis sem vel, interdum nibh. Maecenas ullamcorper condimentum lectus, sed accumsan orci dignissim pretium. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices ... "
    
    
    public var onHeaderDisappear: () -> Void = unimplemented()
    public var onHeaderAppear: () -> Void = unimplemented()
    public var onDisappear: () -> Void = unimplemented()
    
    public init(
        posterStore: AsyncImageViewStore,
        logoStore: AsyncImageViewStore,
        title: String,
        description: String
    ) {
        self.posterStore = posterStore
        self.logoStore = logoStore
        self.title = title
        self.description = description
    }
    
    deinit {
        print("Deinit: \(String(describing: self))")
    }
    
    func handleHeaderDisappear() {
        onHeaderDisappear()
    }
    
    func handleHeaderAppear() {
        onHeaderAppear()
    }
    
    func handleDisappear() {
        onDisappear()
    }
}
