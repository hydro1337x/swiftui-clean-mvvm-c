//
//  AuthCoordinatorStore.swift
//  Ventium
//
//  Created by Benjamin Macanovic on 28.05.2024..
//

import Foundation
import UI

@MainActor
@Observable
final class AuthCoordinatorStore {
    let loginViewStore: LoginViewStore
    
    public var onLogout: (() -> Void)? = { assertionFailure("AuthCoordinatorStore.onLogout is not implemented.") }
    
    init(loginViewStore: LoginViewStore) {
        self.loginViewStore = loginViewStore
        
        bind()
    }
    
    private func bind() {
        loginViewStore.onLogoutButtonTapped = { [weak self] in
            self?.onLogout?()
        }
    }
}
