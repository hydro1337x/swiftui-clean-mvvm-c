//
//  AuthCoordinatorStore.swift
//  Ventium
//
//  Created by Benjamin Macanovic on 28.05.2024..
//

import Foundation
import UI

@Observable
final class AuthCoordinatorStore {
    let loginViewStore: LoginViewStore
    
    public var onLogout: (() -> Void)? = { assertionFailure("AuthCoordinatorStore.onLogout is not implemented.") }
    
    init(loginViewStore: LoginViewStore) {
        self.loginViewStore = loginViewStore
    }
}
