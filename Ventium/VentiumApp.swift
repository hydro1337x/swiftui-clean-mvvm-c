//
//  VentiumApp.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 05.11.2022..
//

import SwiftUI
import UI

@main
struct VentiumApp: App {
    @State var isDebugViewShown = false
    
    let store: RootCoordinatorStore
    let dependencyContainer: DependencyContainer
    
    init() {
        dependencyContainer = DependencyContainer()
        store = dependencyContainer.rootCoordinatorStore
        ThemeProvider().configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootCoordinator(store: store)
                .onShake {
                    isDebugViewShown = true
                }
                .overlay {
                    if isDebugViewShown {
                        dependencyContainer.makeDebugView(
                            onDismiss: {
                                isDebugViewShown = false
                            }
                        )
                    }
                }
        }
    }
}
