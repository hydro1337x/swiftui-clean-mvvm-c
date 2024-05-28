//
//  Binding+Extension.swift
//  UI
//
//  Created by Benjamin Mecanović on 25.11.2022..
//

import SwiftUI

public extension Binding {
    static func bind<Value>(
    _ value: @autoclosure @escaping () -> Value,
    with action: @escaping (Value) -> Void
    ) -> Binding<Value> {
        Binding<Value>(get: value, set: action)
    }
}
