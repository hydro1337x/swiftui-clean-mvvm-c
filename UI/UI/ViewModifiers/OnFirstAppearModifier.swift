//
//  OnFirstAppearModifier.swift
//  UI
//
//  Created by Benjamin Mecanović on 12.03.2023..
//

import SwiftUI

private struct OnFirstAppear: ViewModifier {
    @State private var isFirstAppear = true
    
    let perform: () -> Void

    func body(content: Content) -> some View {
        content.onAppear {
            if isFirstAppear {
                isFirstAppear = false
                perform()
            }
        }
    }
}

public extension View {
    func onFirstAppear(perform: @escaping () -> Void) -> some View {
        modifier(OnFirstAppear(perform: perform))
    }
}
