//
//  AuthFactory.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 15.12.2022..
//

import SwiftUI
import UI
import Domain
import Core

@MainActor
struct AuthFactory {
    func makeLoginScene() -> LoginViewStore {
        return LoginViewStore()
    }
    
    func makeRegistrationScene() {}
}
