//
//  Channel.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 15.02.2023..
//

import Foundation
import Combine

protocol Channelable {}

final class Channel {
    // TODO: - Investigate why Passthrough subject doesn't work here? Backpressure problem ?
    // Only happens when sending events of the same type which menas it is a problem only when
    // the same sink is listening for multiple events of the same time which are send at the same time eg. HomeCoordinatorEvent
    private let subject = CurrentValueSubject<Channelable?, Never>(nil)
    
    func send<C: Channelable>(_ value: C) {
        subject.send(value)
    }
    
    func getValues<C: Channelable>() -> AsyncStream<C> {
        AsyncStream { continuation in
            let task = Task {
                let mappedPublisher = subject
                    .compactMap { $0 }
                    .compactMap { $0 as? C }
                
                for await value in mappedPublisher.values {
                    continuation.yield(value)
                }
            }
            
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
    
    func getValues<C: Channelable>(of type: C.Type) -> AsyncStream<C> {
        getValues()
    }
}
