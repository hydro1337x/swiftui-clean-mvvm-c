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
            let (data, response) = try await session.data(from: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                if 200...300 ~= httpResponse.statusCode {
                    return .success(data)
                } else {
                    return .failure(URLError(.unknown))
                }
            } else {
                return .failure(URLError(.badServerResponse))
            }
        } catch {
            return .failure(error)
        }
    }
}
