//
//  AuthCoordinator.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 26.11.2022..
//

import SwiftUI
import UI

struct AuthCoordinator: View {
    let store: AuthCoordinatorStore
    
    var body: some View {
        NavigationStack {
            LoginView(store: store.loginViewStore)
        }
    }
}
