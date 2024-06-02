//
//  StoryListStoreTests.swift
//
//
//  Created by Benjamin Macanovic on 02.06.2024..
//

import XCTest
@testable import Presentation
@testable import Domain

final class StoryListStoreTests: XCTestCase {
    @MainActor
    func test_initialState() throws {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.focusedItem, nil)
        XCTAssertEqual(sut.stories, [])
        XCTAssertEqual(sut.isLoading, false)
    }
    
    // Try Concurrency extras so tasks can be private
    @MainActor
    func test_storiesFetch() async throws {
        var beforeStoriesFetchCalled = false
        var onStoriesFetchCalled = false
        let spy = Spy()
        let sut = makeSUT(beforeStoriesFetchSpy: spy)
        spy.handler = {
            XCTAssertTrue(sut.isLoading)
            beforeStoriesFetchCalled = true
        }
        
        sut.onStoriesFetch = { stories in
            XCTAssertEqual(stories, sut.stories)
            onStoriesFetchCalled = true
        }
        
        sut.handleOnAppear()
        
        try await sut.initialTask?.value
        
        XCTAssertEqual(sut.stories.count, 1)
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(beforeStoriesFetchCalled)
        XCTAssertTrue(onStoriesFetchCalled)
        
    }
}

extension StoryListStoreTests {
    struct TestError: Error {}
    
    class Spy {
        var handler: (() -> Void)?
    }
    
    @MainActor
    func makeSUT(beforeStoriesFetchSpy: Spy? = nil) -> StoryListStore {
        let store = StoryListStore(
            fetchStoriesUseCase: .init(execute: { [makeLocation, makeMedia] _ in
                beforeStoriesFetchSpy?.handler?()
                return .success([.init(id: UUID().uuidString, location: makeLocation(), medias: [makeMedia()], expiresAt: Date())])
            }),
            makeAsyncImageViewStore: { _ in
                    .init(fetchImage: {
                        .failure(TestError())
                    })
            }
        )
        
        store.onItemTap = { _ in XCTFail() }
        store.onStoriesFetch = { _ in XCTFail() }
        
        return store
    }
    
    private func makeLocation() -> Location {
        .init(id: UUID().uuidString, name: "Name", address: "Add", medias: [makeMedia()])
    }
    
    private func makeMedia() -> Media {
        .init(url: URL(string: "www.fake.com")!, isFavorite: true)
    }
}
