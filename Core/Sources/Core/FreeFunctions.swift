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

// MARK: () -> Void Implementation
public func unimplemented(_ file: StaticString = #file, _ line: UInt = #line) -> () -> Void {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
    }
}

// MARK: () async -> Void Implementation
public func unimplemented(_ file: StaticString = #file, _ line: UInt = #line) -> () async -> Void {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
    }
}

// MARK: (I) -> Void Implementation
public func unimplemented<I>(_ file: StaticString = #file, _ line: UInt = #line) -> (I) -> Void {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
    }
}

// MARK: (I) async -> Void Implementation
public func unimplemented<I>(_ file: StaticString = #file, _ line: UInt = #line) -> (I) async -> Void {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
    }
}

// MARK: () -> O Implementation
public func unimplemented<O>(_ defaultReturnValue: O, _ file: StaticString = #file, _ line: UInt = #line) -> () -> O {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
        return defaultReturnValue
    }
}
// MARK: () -> O? Implementation
public func unimplemented<O>(_ file: StaticString = #file, _ line: UInt = #line) -> () -> O? {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
        return nil
    }
}

// MARK: () async -> O Implementation
public func unimplemented<O>(_ defaultReturnValue: O, _ file: StaticString = #file, _ line: UInt = #line) -> () async -> O {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
        return defaultReturnValue
    }
}

// MARK: () async -> O? Implementation
public func unimplemented<O>(_ file: StaticString = #file, _ line: UInt = #line) -> () async -> O? {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
        return nil
    }
}

// MARK: (I) -> O Implementation
public func unimplemented<I, O>(_ defaultReturnValue: O, _ file: StaticString = #file, _ line: UInt = #line) -> (I) -> O {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
        return defaultReturnValue
    }
}

// MARK: (I) -> O? Implementation
public func unimplemented<I, O>(_ file: StaticString = #file, _ line: UInt = #line) -> (I) -> O? {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
        return nil
    }
}

// MARK: (I) async -> O Implementation
public func unimplemented<I, O>(_ defaultReturnValue: O, _ file: StaticString = #file, _ line: UInt = #line) -> (I) async -> O {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
        return defaultReturnValue
    }
}

// MARK: (I) async -> O? Implementation
public func unimplemented<I, O>(_ file: StaticString = #file, _ line: UInt = #line) -> (I) async -> O? {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
        return nil
    }
}
