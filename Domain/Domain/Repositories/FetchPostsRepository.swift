//
//  FetchPostsRepository.swift
//  Domain
//
//  Created by Benjamin Mecanović on 05.11.2022..
//

import Foundation

public protocol FetchPostsRepository  {
    func fetch(_ request: FetchPostsRequest) async -> Result<[Post], Error>
}
