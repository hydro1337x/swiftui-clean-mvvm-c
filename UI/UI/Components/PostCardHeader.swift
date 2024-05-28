//
//  PostCardHeader.swift
//  UI
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import SwiftUI

struct PostCardHeader: View {
    let title: String
    let imageURL: URL
    let tags: [String]

    var body: some View {
        HStack(spacing: 8) {
            AsyncImageView(url: imageURL, placeholderResizingMode: .stretch)
                .frame(width: 36, height: 36)
                .background(Color.blue)
                .cornerRadius(18)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.monserrat(.medium, 12))
                TagsView(tags: tags)
            }
        }
    }
}

struct PostCardHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostCardHeader(
                title: "Some Cafee",
                imageURL: URL(string: "https://citypal.me/wp-content/uploads/2016/04/01-e1462017909580.jpg")!,
                tags: ["nightlife", "concert", "standup"]
            )
            PostCardHeader(
                title: "Some Cafee",
                imageURL: URL(string: "www.fakeurl.com")!,
                tags: ["nightlife", "concert", "standup"]
            )
        }
        .modifier(OnLoadViewModifier {
            ThemeProvider().configure()
        })

    }
}
