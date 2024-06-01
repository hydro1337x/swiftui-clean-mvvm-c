//
//  StoryPager.swift
//  UI
//
//  Created by Benjamin Mecanović on 17.02.2023..
//

import SwiftUI

public struct StoryPager: View {
    let store: StoryPagerStore
    @State private var localStore = LocalStore()
    
    public init(store: StoryPagerStore) {
        self.store = store
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                if let imageStore = store.selectedItem?.backgroundImageStore {
                    AsyncImageView(store: imageStore)
                }
                
                HStack {
                    Button(action: store.previousItem, label: { Color.clear })
                    Button(action: store.nextItem, label: { Color.clear })
                }
            }
            .frame(width: proxy.size.width)
            .background(Color(.background))
            .clipped()
            .offset(localStore.offset)
            .scaleEffect(localStore.scale)
            .disabled(!localStore.isEnabled)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        localStore.handleDragChanged(with: value)
                    }
                    .onEnded { _ in
                        localStore.handleDragEnded(callback: store.dragEnded)
                    }
            )
            .animation(.default, value: localStore.scale)
            .animation(.linear, value: localStore.offset)
        }
    }
}

private extension StoryPager {
    @Observable
    class LocalStore {
        var offset: CGSize = .zero
        var isEnabled: Bool = true
        var scale: CGFloat = 1
        
        func handleDragChanged(with value: DragGesture.Value) {
            isEnabled = false
            offset = value.translation
            let scale = 1 - (value.translation.height / 500)
            guard scale > 0.75, scale <= 1 else { return }
            self.scale = scale
        }
        
        func handleDragEnded(callback: () -> Void) {
            if scale < 0.8 {
                callback()
            }
            scale = 1
            offset = .zero
            isEnabled = true
        }
    }
}

//struct StoryPager_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryPager(urls: [])
//    }
//}
