//
//  OnLoadViewModifier.swift
//  UI
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import SwiftUI

public struct OnLoadViewModifier: ViewModifier {
    public init(_ closure: () -> Void) {
        closure()
    }

    public func body(content: Content) -> some View {
        content
    }
}
