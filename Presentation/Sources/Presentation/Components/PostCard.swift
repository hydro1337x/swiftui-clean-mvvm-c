//
//  PostCard.swift
//  UI
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import SwiftUI

struct PostCard: View {
    let locationName: String
    let postName: String
    let posterURL: URL
    let avatarURL: URL
    let tags: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            PostCardHeader(
                title: locationName,
                imageURL: avatarURL,
                tags: tags
            )
            
            AsyncImageView(url: posterURL)
                .frame(height: 220)
                .clipped()
                .cornerRadius(8)
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(postName)
                            .font(.monserrat(.bold, 14))
                            .foregroundColor(Color(.foreground))
                        HStack {
                            Chip(image: .bell, text: "2 weeks left")
                            Chip(image: .person, text: "168 coming")
                        }
                    }
                    .padding(10)
                }
        }
    }
}

struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostCard(locationName: "Cafee Name",
                     postName: "Recesion Party",
                     posterURL: URL(string: "https://citypal.me/wp-content/uploads/2016/04/01-e1462017909580.jpg")!,
                     avatarURL: URL(string: "https://dw0i2gv3d32l1.cloudfront.net/uploads/stage/stage_image/52688/optimized_large_thumb_stage.jpg")!,
                     tags: ["nightlife", "concert", "standup"]
            )
            PostCard(locationName: "Cafee Name",
                     postName: "Recesion Party",
                     posterURL: URL(string: "www.fakeurl.com")!,
                     avatarURL: URL(string: "www.fakeurl.com")!,
                     tags: ["nightlife", "concert", "standup"]
            )
            .previewLayout(.sizeThatFits)
        }
        .modifier(OnLoadViewModifier {
            ThemeProvider().configure()
        })
    }
}
