//
//  ApolloFetchPostsRepositoryTests.swift
//  DataTests
//
//  Created by Benjamin Mecanović on 28.12.2022..
//

import XCTest
import Data
import Domain
import Apollo

final class ApolloFetchPostsRepositoryTests: XCTestCase {

    func test() async {
        let apolloQueue = DispatchQueue(label: "com.hydro1337x.ventium.fetchPostsQueueTest")
        let mediaBaseURL = "https://ik.imagekit.io/smeybgkgf/tr:h-300/"
        let apolloClient = ApolloClient(url: URL(string: "https://ventium-7lx4w6qtva-ew.a.run.app/graphql")!)
        let paginator = Paginator<Post>()
        let sut = ApolloFetchPostsRepository(client: apolloClient, paginator: paginator, queue: apolloQueue, mediaBaseURL: mediaBaseURL)
        
        var task: Task<Void, Never>?
        
        task = Task {
            _ = await sut.fetch(.init(isInitial: true, filters: []))
            print("Task - Finished")
            
        }
        
        
        try! await Task.sleep(nanoseconds: 1_000_000)
        
        print("Task - Before Cancellation")
        
        task?.cancel()
        
        print("Task - After Cancellation")
        
        _ = await task?.result
    }

}
