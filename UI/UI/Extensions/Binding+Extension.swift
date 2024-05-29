//
//  Binding+Extension.swift
//  UI
//
//  Created by Benjamin Mecanović on 25.11.2022..
//

import SwiftUI

public extension Binding {
    static func bind<T>(
    _ value: @autoclosure @escaping () -> T,
    with action: @escaping (T) -> Void
    ) -> Binding<T> {
        Binding<T>(get: value, set: action)
    }
}
