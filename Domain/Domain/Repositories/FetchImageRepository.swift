//
//  FetchImageRepository.swift
//  Domain
//
//  Created by Benjamin Mecanović on 05.11.2022..
//

import Foundation

public protocol FetchImageRepository {
    func fetch(_ request: URL) async -> Result<Data, Error>
}
