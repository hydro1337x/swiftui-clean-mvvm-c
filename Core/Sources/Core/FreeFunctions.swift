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

public typealias VoidClosure = () -> Void

public func unimplemented(_ file: StaticString = #file, _ line: UInt = #line) -> () -> Void {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
    }
}

public typealias AsyncVoidClosure = () async -> Void

public func unimplemented(_ file: StaticString = #file, _ line: UInt = #line) -> () async -> Void {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
    }
}

public typealias InputClosure<I> = (I) -> Void

public func unimplemented<I>(_ file: StaticString = #file, _ line: UInt = #line) -> (I) -> Void {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
    }
}

public typealias InputAsyncClosure<I> = (I) async -> Void

public func unimplemented<I>(_ file: StaticString = #file, _ line: UInt = #line) -> (I) async -> Void {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
    }
}

public typealias OutputClosure<O> = () -> O

public func unimplemented<O>(_ defaultReturnValue: O, _ file: StaticString = #file, _ line: UInt = #line) -> () -> O {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
        return defaultReturnValue
    }
}

public func unimplemented<O>(_ file: StaticString = #file, _ line: UInt = #line) -> () -> O? {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
        return nil
    }
}

public typealias OutputAsyncClosure<O> = () async -> O

public func unimplemented<O>(_ defaultReturnValue: O, _ file: StaticString = #file, _ line: UInt = #line) -> () async -> O {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
        return defaultReturnValue
    }
}

public func unimplemented<O>(_ file: StaticString = #file, _ line: UInt = #line) -> () async -> O? {
    return {
        assertionFailure("Unimplemented closure", file: file, line: line)
        return nil
    }
}

public typealias InoutClosure<I, O> = (I) -> O

public func unimplemented<I, O>(_ defaultReturnValue: O, _ file: StaticString = #file, _ line: UInt = #line) -> (I) -> O {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
        return defaultReturnValue
    }
}

public func unimplemented<I, O>(_ file: StaticString = #file, _ line: UInt = #line) -> (I) -> O? {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
        return nil
    }
}

public typealias InoutAsyncClosure<I, O> = (I) -> O

public func unimplemented<I, O>(_ defaultReturnValue: O, _ file: StaticString = #file, _ line: UInt = #line) -> (I) async -> O {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
        return defaultReturnValue
    }
}

public func unimplemented<I, O>(_ file: StaticString = #file, _ line: UInt = #line) -> (I) async -> O? {
    return { _ in
        assertionFailure("Unimplemented closure", file: file, line: line)
        return nil
    }
}
