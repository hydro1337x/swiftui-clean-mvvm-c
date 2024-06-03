//
//  AsyncImageViewStore.swift
//  UI
//
//  Created by Benjamin Macanovic on 30.05.2024..
//

import Foundation
import Domain
import Core

@MainActor
@Observable
public final class AsyncImageViewStore {
    enum State: Equatable {
        case initial
        case loading
        case loaded(Data)
        case failed
    }
    
    private(set) var state: State = .initial
    
    private let fetchImage: OutputAsyncClosure<Result<Data, Error>>
    
    var task: Task<Void, Never>?
    
    public init(
        fetchImage: @escaping () async -> Result<Data, Error>
    ) {
        self.fetchImage = fetchImage
    }
    
    func handleOnAppear() {
        fetch()
    }
    
    func handleRetryButtonTapped() {
        fetch()
    }
    
    func handleOnDisappear() {
        task?.cancel()
    }
    
    private func fetch() {
        task?.cancel()
        
        task = Task { @MainActor in
            state = .loading
            
            let result = await fetchImage()
            
            switch result {
            case .success(let data):
                state = .loaded(data)
            case .failure:
                state = .failed
            }
        }
    }
}

extension AsyncImageViewStore: Identifiable, ReferenceHashable {}
