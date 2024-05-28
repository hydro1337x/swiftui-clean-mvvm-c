//
//  PostDetailsView.swift
//  UI
//
//  Created by Benjamin Mecanović on 03.03.2023..
//

import SwiftUI

public struct PostDetailsView: View {
    let store: PostDetailsViewStore
    @State private var localStore = LocalStore()
    
    public init(store: PostDetailsViewStore) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                header
                    .offset(y: localStore.parallaxOffset.y)
                    .opacity(localStore.alpha)
                    .scaleEffect(x: localStore.scale, y: localStore.scale, anchor: .top)
                
                OffsetObservingScrollView(offset: .bind(localStore.offset, with: { localStore.setOffset($0) })) {
                    VStack(spacing: 10) {
                        Text("Address")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Time")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Participants")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(store.description)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 25)
                        
                        Text(store.text)
                            .foregroundColor(.white)
                        Text(store.text)
                            .foregroundColor(.white)
                        Text(store.text)
                            .foregroundColor(.white)
                        Text(store.text)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 250 + 25)
                    .padding(.horizontal, 16)
                }
            }
        }
        .background(Color(.background))
        .edgesIgnoringSafeArea(.top)
        .onChange(of: localStore.isHeaderVisible) { isHeaderVisible in
            isHeaderVisible ? store.handleHeaderAppear() : store.handleHeaderDisappear()
        }
        .onDisappear(perform: store.handleDisappear)
    }
    
    var header: some View {
        ZStack(alignment: .bottom) {
            AsyncImageView(url: store.posterURL)
            
            LinearGradient(colors: [.clear, Color(.background)], startPoint: .center, endPoint: .bottom)
            
            VStack(spacing: 10) {
                AsyncImageView(url: store.logoURL)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                
                Text(store.title)
                    .foregroundColor(.white)
                    .font(.monserrat(.bold, 24))
            }
            .padding(.bottom, 16)
        }
        .frame(height: 250)
    }
}

private extension PostDetailsView {
    struct LocalStore {
        var alpha: CGFloat = 1
        var offset: CGPoint = .zero
        var parallaxOffset: CGPoint = .zero
        var scale: CGFloat = 1
        var isHeaderVisible = true
        
        private var _isHeaderVisible = true
        
        mutating func setOffset(_ offset: CGPoint) {
            self.offset = offset
            alpha = calculateAlpha(from: offset.y)
            scale = calculateScale(from: offset.y)
            parallaxOffset = calculateParallaxOffset(from: offset)
            _isHeaderVisible = determineIsHeaderVisible(from: alpha)
            
            if _isHeaderVisible != isHeaderVisible {
                isHeaderVisible = _isHeaderVisible
            }
        }
        
        private func calculateAlpha(from yOffset: CGFloat) -> CGFloat {
            let factor = yOffset / 150
            let value = 1 - min(factor, 1)
            return value
        }
        
        private func calculateScale(from yOffset: CGFloat) -> CGFloat {
            let factor = yOffset / 400
            guard factor < 0 else { return 1 }
            return 1 + abs(factor)
        }
        
        private func calculateParallaxOffset(from offset: CGPoint) -> CGPoint {
            let factor = offset.y / 2
            guard factor > 0 else { return .zero }
            return CGPoint(x: offset.x, y: -factor)
        }
        
        private func determineIsHeaderVisible(from alpha: CGFloat) -> Bool {
            alpha <= 0.0 ? false : true
        }
    }
}

//struct PostDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        let url = URL(string: "https://citypal.me/wp-content/uploads/2016/04/01-e1462017909580.jpg")!
//        PostDetailsView(
//            state: .init(
//                posterURL: url,
//                logoURL: url,
//                title: "Title",
//                description: "Description"
//            ),
//            actions: .init(onHeaderDisappear: {}, onHeaderAppear: {}, onDisappear: {})
//        )
//    }
//}
