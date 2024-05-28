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
        .onChange(of: first.wrappedValue) { second.wrappedValue = $0 }
        .onChange(of: second.wrappedValue) { first.wrappedValue = $0 }
    }
}
