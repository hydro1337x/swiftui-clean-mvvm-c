//
//  AsyncImageView_Old.swift
//  UI
//
//  Created by Benjamin Mecanović on 06.03.2023..
//

import SwiftUI

struct AsyncImageView_Old: View {
    enum LoadState: Equatable {
        case empty
        case image
        case error
    }
    
    let url: URL?
    let contentMode: ContentMode
    let placeholderResizingMode: Image.ResizingMode
    
    init(
        url: URL?,
        contentMode: ContentMode = .fill,
        placeholderResizingMode: Image.ResizingMode = .tile
    ) {
        self.url = url
        self.contentMode = contentMode
        self.placeholderResizingMode = placeholderResizingMode
    }
    
    var body: some View {
        GeometryReader { proxy in
            AsyncImage(url: url) { phase in
                Group {
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: contentMode)
                            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                            .clipped()
                    default:
                        Image(VEImage.placeholderPattern)
                            .resizable(resizingMode: placeholderResizingMode)
                            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                            .clipped()
                    }
                }
            }
        }
    }
}

struct AsyncImageView_Old_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView_Old(url: URL(string: "https://citypal.me/wp-content/uploads/2016/04/01-e1462017909580.jpg"))
            .frame(height: 100)
    }
}
