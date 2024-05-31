//
//  AsyncImageView.swift
//  UI
//
//  Created by Benjamin Macanovic on 29.05.2024..
//

import SwiftUI

struct AsyncImageView: View {
    let store: AsyncImageViewStore
    let contentMode: ContentMode
    let placeholderResizingMode: Image.ResizingMode
    
    init(
        store: AsyncImageViewStore,
        contentMode: ContentMode = .fill,
        placeholderResizingMode: Image.ResizingMode = .tile
    ) {
        self.store = store
        self.contentMode = contentMode
        self.placeholderResizingMode = placeholderResizingMode
    }
    
    var body: some View {
        GeometryReader { proxy in
            switch store.state {
            case .initial:
                ZStack {
                    Image(VEImage.placeholderPattern)
                        .resizable(resizingMode: placeholderResizingMode)
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                        .clipped()
                }
            case .loading:
                ZStack {
                    Image(VEImage.placeholderPattern)
                        .resizable(resizingMode: placeholderResizingMode)
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                        .clipped()
                    ProgressView()
                        .tint(Color(.accent))
                        .scaleEffect(2)
                }
            case .loaded(let data):
                Image(uiImage: UIImage(data: data) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                    .clipped()
            case .failed:
                ZStack {
                    Image(VEImage.placeholderPattern)
                        .resizable(resizingMode: placeholderResizingMode)
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                        .clipped()
                    Button(action: store.handleRetryButtonTapped) {
                        Text("Retry")
                            .frame(width: 100, height: 44)
                    }
                    .tint(Color(.accent))
                }
            }
        }
        .animation(.default, value: store.state)
        .onAppear(perform: store.handleOnAppear)
        .onDisappear(perform: store.handleOnDisappear)
    }
}

#Preview {
    VStack {
        AsyncImageView(store: .init(fetchImage: {
            try! await Task.sleep(for: .seconds(1000000000))
            return .success(UIImage(systemName: "pencil")!.pngData()!)
        }))
            .frame(height: 100)
        AsyncImageView(store: .init(fetchImage: { .success(UIImage(systemName: "pencil")!.pngData()!)}))
            .frame(height: 100)
        AsyncImageView(store: .init(fetchImage: { .failure(URLError(.badURL)) }))
            .frame(height: 100)
    }
}
