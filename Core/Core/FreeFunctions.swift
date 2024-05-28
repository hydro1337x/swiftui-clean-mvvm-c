//
//  FreeFunctions.swift
//  Core
//
//  Created by Benjamin Mecanović on 26.11.2022..
//

import Foundation

public func dispatchOnMainQueue(_ operation: @Sendable @escaping () -> Void) {
    if Thread.isMainThread {
        operation()
    } else {
        DispatchQueue.main.async {
            operation()
        }
    }
}
