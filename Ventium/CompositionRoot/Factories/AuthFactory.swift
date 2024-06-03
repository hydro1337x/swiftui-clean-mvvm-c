//
//  AuthFactory.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 15.12.2022..
//

import SwiftUI
import Presentation
import Domain
import Core

@MainActor
struct AuthFactory {
    func makeLoginScene() -> LoginViewStore {
        let store = LoginViewStore()
        return store
    }
    
    func makeRegistrationScene() {}
}
