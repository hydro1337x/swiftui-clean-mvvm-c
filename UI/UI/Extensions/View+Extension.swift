//
//  View+Extension.swift
//  UI
//
//  Created by Benjamin Mecanović on 25.11.2022..
//

import SwiftUI

public extension View {
    func synchronize<Value: Equatable>(
        _ first: Binding<Value>,
        _ second: FocusState<Value>.Binding
    ) -> some View {
        self
            .onChange(of: first.wrappedValue) { _, newValue in
                second.wrappedValue = newValue
            }
            .onChange(of: second.wrappedValue) { _, newValue in
                first.wrappedValue = newValue
            }
    }
}
