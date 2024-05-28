//
//  NetworkMonitor.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 10.03.2023..
//

import Foundation
import Network

class NetworkMonitor {
    private let monitor = NWPathMonitor()
    let queue: DispatchQueue
    
    private var lastValue: Bool?
    
    var reachabilityStream: AsyncStream<Bool> {
        makeMonitor()
    }
    
    init(queue: DispatchQueue) {
        self.queue = queue
        monitor.start(queue: queue)
    }
    
    private func makeMonitor() -> AsyncStream<Bool> {
        AsyncStream<Bool> { continuation in
            monitor.pathUpdateHandler = { path in
                let value = path.status == .satisfied ? true : false
                
                if value != self.lastValue {
                    self.lastValue = value
                    continuation.yield(value)
                }
            }
            
            if let lastValue {
                continuation.yield(lastValue)
            }
        }
    }
}
