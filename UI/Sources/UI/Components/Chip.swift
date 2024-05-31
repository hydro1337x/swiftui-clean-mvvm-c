//
//  Chip.swift
//  UI
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import SwiftUI

struct Chip: View {
    let image: VEImage
    let text: String

    var body: some View {
        HStack {
            Image(image)
                .renderingMode(.template)
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(Color(.foreground))
            Text(text)
                .font(Font.monserrat(.semiBold, 10))
                .foregroundColor(Color(.foreground))
        }
    }
}

struct Chip_Previews: PreviewProvider {
    static var previews: some View {
        Chip(image: .person, text: "168 going")
            .modifier(OnLoadViewModifier {
                ThemeProvider().configure()
            })
            .background(Color.black)
    }
}
