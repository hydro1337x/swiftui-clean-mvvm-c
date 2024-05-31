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
    enum State {
        case initial
        case loaded(Data)
        case failed
    }
    
    private(set) var state: State = .initial
    
    private let fetchImage: () async -> Result<Data, Error>
    
    var task: Task<Void, Never>?
    
    public init(
        fetchImage: @escaping () async -> Result<Data, Error>
    ) {
        self.fetchImage = fetchImage
    }
    
    func handleOnAppear() {
        task?.cancel()
        
        task = Task { @MainActor in
            let result = await fetchImage()
            
            switch result {
            case .success(let data):
                state = .loaded(data)
            case .failure:
                state = .failed
            }
        }
    }
    
    func handleOnDisappear() {
        task?.cancel()
    }
}

extension AsyncImageViewStore: Identifiable, ReferenceHashable {}
