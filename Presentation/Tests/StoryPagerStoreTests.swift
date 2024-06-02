//
//  StoryPagerStoreTests.swift
//  
//
//  Created by Benjamin Macanovic on 02.06.2024..
//

import XCTest
@testable import Presentation

final class StoryPagerStoreTests: XCTestCase {
    @MainActor
    func testExample() throws {
        let _ = makeSUT()
    }
}

extension StoryPagerStoreTests {
    @MainActor
    func makeSUT() -> StoryPagerStore {
        .init()
    }
}
