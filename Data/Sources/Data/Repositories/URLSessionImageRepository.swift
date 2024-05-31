//
//  URLSessionImageRepository.swift
//  Data
//
//  Created by Benjamin Macanovic on 29.05.2024..
//

import Foundation
import Domain

public struct URLSessionImageRepository: FetchImageRepository {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func fetch(_ request: URL) async -> Result<Data, any Error> {
        do {
            let (data, _) = try await session.data(from: request)
            
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
