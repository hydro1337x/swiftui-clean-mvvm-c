//
//  StoryThumbnail.swift
//  UI
//
//  Created by Benjamin Mecanović on 04.01.2023..
//

import SwiftUI

struct StoryThumbnail: View {
    let backgroundURL: URL
    let logoURL: URL
    let title: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { proxy in
                AsyncImageView(url: backgroundURL)
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            }
            
            LinearGradient(colors: [.clear, Color(.background)], startPoint: .top, endPoint: .bottom)
            
            VStack {
                AsyncImageView(url: logoURL)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                
                Text(title)
                    .font(.monserrat(.medium, 12))
                    .foregroundColor(.white)
                    .frame(minHeight: 12)
            }
            .padding(.bottom, 5)
        }
    }
}

//struct StoryThumbnail_Previews: PreviewProvider {
//    static let url = URL(string: "https://img.freepik.com/photos-gratuite/vue-arriere-foule-fans-regardant-performances-direct-concert-musique-nuit-espace-copie_637285-544.jpg")!
//    static var previews: some View {
//        StoryThumbnail(backgroundURL: url, logoURL: url, title: "Location Name")
//            .frame(width: 150, height: 300)
//            .clipped()
//            .modifier(OnLoadViewModifier({
//                ThemeProvider().configure()
//            }))
//    }
//}
