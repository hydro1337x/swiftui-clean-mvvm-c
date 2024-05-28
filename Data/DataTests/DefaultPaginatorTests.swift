//
//  DefaultPaginatorTests.swift
//  DataTests
//
//  Created by Benjamin Mecanović on 10.11.2022..
//

import XCTest
import Data

final class DefaultPaginatorTests: XCTestCase {
    
    func test_paginate_initialState() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.cursor, 0)
    }
    
    func test_singlePage() {
        let sut = makeSUT()
        
        let responses = [
            makePaginatedResponse(limit: 10, cursor: 0, hasNext: false),
            // Fake if limit is reached but another fetch is triggered, the values are not important
            makePaginatedResponse(limit: 10, cursor: 10, hasNext: false)
        ]
        
        let tuples = responses.compactMap { response -> (Int, Int) in
            (sut.paginate(response).count, sut.cursor)
        }
        
        let (elements, cursorValues) = tuples.reduce(([Int](), [Int]())) { partialResult, tuple in
            var elements = partialResult.0
            elements.append(tuple.0)
            var cursorElements = partialResult.1
            cursorElements.append(tuple.1)
            return (elements, cursorElements)
        }
        
        XCTAssertEqual(elements, [10, 10])
        XCTAssertEqual(cursorValues, [10, 10])
    }

    func test_multiplePages() {
        let sut = makeSUT()
        
        let responses = [
            makePaginatedResponse(limit: 10, cursor: 0, hasNext: true),
            makePaginatedResponse(limit: 10, cursor: 10, hasNext: true),
            makePaginatedResponse(limit: 10, cursor: 20, hasNext: true),
            makePaginatedResponse(limit: 10, cursor: 30, hasNext: true),
            makePaginatedResponse(limit: 10, cursor: 40, hasNext: false),
            // Fake if limit is reached but another fetch is triggered, the values are not important
            makePaginatedResponse(limit: 10, cursor: 50, hasNext: false)
        ]
        
        let tuples = responses.compactMap { response -> (Int, Int) in
            (sut.paginate(response).count, sut.cursor)
        }
        
        let (elements, cursorValues) = tuples.reduce(([Int](), [Int]())) { partialResult, tuple in
            var elements = partialResult.0
            elements.append(tuple.0)
            var cursorElements = partialResult.1
            cursorElements.append(tuple.1)
            return (elements, cursorElements)
        }
        
        XCTAssertEqual(elements, [10, 20, 30, 40, 50, 50])
        XCTAssertEqual(cursorValues, [10, 20, 30, 40, 50, 50])
    }

}

extension DefaultPaginatorTests {
    func makeSUT() -> Paginator<Int> {
        let sut = Paginator<Int>()
        
        return sut
    }
    
    func makePaginatedResponse(limit: Int, cursor: Int, hasNext: Bool) -> PaginatedResponse<Int> {
        let page = makePage(limit: limit)
        let pagination = Pagination(
            cursor: cursor,
            hasNext: hasNext
        )
        return PaginatedResponse<Int>(page: page, pagination: pagination)
    }
    
    func makePage(limit: Int) -> [Int] {
        Array(repeating: 1, count: limit)
            .enumerated()
            .map { index, _ in
                index
            }
    }
}
