//
//  HomeFeedTests.swift
//  UITests
//
//  Created by Benjamin Mecanović on 12.12.2022..
//

import XCTest
@testable import UI
import Domain
import Combine

final class HomeFeedTests: XCTestCase {
    let error = URLError(.unknown)
    lazy var firstPage = makePosts()
    lazy var secondPage = makePosts(startingIndex: 10)

    func test_initialState() {
        let (sut, _, _) = makeSUT()
        
        XCTAssertEqual(sut.state, HomeFeedState())
    }
    
    func test_onAppearAndFetchSuccessful_setState() async {
        let (sut, _, mapper) = makeSUT()
        
        sut.handleOnAppear()
        
        var values: [Bool] = []
        let cancellable = sut.$state.map(\.isLoading).sink { value in
            values.append(value)
        }
        
        _ = await sut.initialTask?.result
        
        XCTAssertEqual(values, [false, true, false])
        XCTAssertEqual(sut.state.posts, firstPage.map(mapper.map))
        
        cancellable.cancel()
    }
    
    func test_onAppearAndFetchFailed_triggerErrorMessage() async {
        var message: String?
        
        let (sut, mock, _) = makeSUT { m in
            message = m
        }
        
        await mock.setResponse(.failure(error))
        
        sut.handleOnAppear()
        
        var values: [Bool] = []
        let cancellable = sut.$state.map(\.isLoading).sink { value in
            values.append(value)
        }
        
        _ = await sut.initialTask?.result
        
        XCTAssertEqual(values, [false, true, false])
        XCTAssertEqual(sut.state.posts, [])
        XCTAssertEqual(message, error.localizedDescription)
        
        cancellable.cancel()
    }

    func test_onFirstItemAppear_doesNotFetch() async throws {
        let (sut, _, mapper) = makeSUT()
        
        let first = try XCTUnwrap(firstPage.first)
        
        sut.handleOnItemAppear(mapper.map(first))
        
        _ = await sut.consecutiveTask?.result
        
        XCTAssertEqual(sut.state, HomeFeedState())
    }
    
    func test_onLastItemAppearAndFetchSuccessful_setState() async throws {
        let (sut, mock, mapper) = makeSUT()
        
        let mappedFirstPage = firstPage.map(mapper.map)
        sut.state.posts = mappedFirstPage
        
        let mappedSecondPage = secondPage.map(mapper.map)
        
        let last = try XCTUnwrap(mappedFirstPage.last)
        
        await mock.setResponse(.success(secondPage))
        
        sut.handleOnItemAppear(last)
        
        var values: [Bool] = []
        let cancellable = sut.$state.map(\.isLoading).sink { value in
            values.append(value)
        }
        
        _ = await sut.consecutiveTask?.result
        
        XCTAssertEqual(values, [false, true, false])
        XCTAssertEqual(sut.state.posts, mappedSecondPage)
        
        cancellable.cancel()
    }
    
    func test_onLastItemAppearAndFetchFailed_triggerErrorMessage() async throws {
        var message: String?
        
        let (sut, mock, mapper) = makeSUT { message = $0 }
        
        let mappedFirstPage = firstPage.map(mapper.map)
        sut.state.posts = mappedFirstPage
        
        await mock.setResponse(.failure(error))
        
        let last = try XCTUnwrap(mappedFirstPage.last)
        
        sut.handleOnItemAppear(last)
        
        var values: [Bool] = []
        let cancellable = sut.$state.map(\.isLoading).sink { value in
            values.append(value)
        }
        
        _ = await sut.consecutiveTask?.result
        
        XCTAssertEqual(values, [false, true, false])
        XCTAssertEqual(sut.state.posts, mappedFirstPage)
        XCTAssertEqual(message, error.localizedDescription)
        
        cancellable.cancel()
    }
    
    func test_onRefreshAndFetchSuccessful_setState() async {
        let (sut, _, mapper) = makeSUT()
        
        var values: [Bool] = []
        let cancellable = sut.$state.map(\.isLoading).sink { value in
            values.append(value)
        }
        
        await sut.handleOnRefresh()
        
        XCTAssertEqual(values, [false, true, false])
        XCTAssertEqual(sut.state.posts, firstPage.map(mapper.map))
        
        cancellable.cancel()
    }
    
    func test_onRefreshAndFetchFailed_triggerErrorMessage() async {
        var message: String?
        
        let (sut, mock, _) = makeSUT { m in
            message = m
        }
        
        await mock.setResponse(.failure(error))
        
        var values: [Bool] = []
        let cancellable = sut.$state.map(\.isLoading).sink { value in
            values.append(value)
        }
        
        await sut.handleOnRefresh()
        
        XCTAssertEqual(values, [false, true, false])
        XCTAssertEqual(sut.state.posts, [])
        XCTAssertEqual(message, error.localizedDescription)
        
        cancellable.cancel()
    }
}

extension HomeFeedTests {
    func makeSUT(onErrorMessage: @escaping (String) -> Void = { _ in }) -> (HomeFeedStore, FetchPostsUseCaseMock, PostMapper) {
        let response = makePosts()
        let useCaseMock = FetchPostsUseCaseMock(result: .success(response))
        let mapper = PostMapper()
        
        let sut = HomeFeedStore(fetchPostsUseCase: useCaseMock, postMapper: mapper, onErrorMessage: onErrorMessage)
        
        trackForMemoryLeaks(sut)
        
        return (sut, useCaseMock, mapper)
    }
    
    func makePosts(startingIndex: Int = 0) -> [Post] {
        Array(repeating: 1, count: 10).enumerated().map { index, _ in
            let idx = startingIndex + index
            return Post(id: idx.description, name: "Name\(idx)", description: "Description\(idx)")
        }
    }
}

actor FetchPostsUseCaseMock: FetchPostsUseCase {
    var result: Result<[Post], Error>
    
    init(result: Result<[Post], Error>) {
        self.result = result
    }
    
    func setResponse(_ result: Result<[Post], Error>) {
        self.result = result
    }
    
    func execute(_ input: Domain.FetchPostsInput) async -> Result<Array<Domain.Post>, Error> {
        result
    }
}

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potentional memory leak",
                file: file,
                line: line
            )
        }
    }
}
