//
//  NetworkMonitorDecorator.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 11.03.2023..
//

import Foundation

class NetworkMonitorDecorator: NetworkMonitor {
    private var callback: ((Bool) -> Void)?
    
    override var reachabilityStream: AsyncStream<Bool> {
        return AsyncStream<Bool> { continuation in
            Task {
                for await value in super.reachabilityStream {
                    continuation.yield(value)
                }
            }
            
            callback = { value in
                continuation.yield(value)
            }
        }
    }
    
    init(_ decoratee: NetworkMonitor) {
        super.init(queue: decoratee.queue)
    }
    
    func send(_ value: Bool) {
        queue.async { [weak self] in
            self?.callback?(value)
        }
    }
}
