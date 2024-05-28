//
//  NetworkBanner.swift
//  UI
//
//  Created by Benjamin Mecanović on 10.03.2023..
//

import SwiftUI

public struct NetworkBanner: View {
    let message: String = "No internet connection"
    
    public init() {}
    
    public var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Spacer()
                Image(systemName: "wifi.exclamationmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .padding(.leading, 10)
                
                Text(message)
                    .font(.monserrat(.medium, 14))
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 5)
        }
        .background(Color(.systemOrange))
    }
}

struct NetworkBanner_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                NetworkBanner()
                    .modifier(OnLoadViewModifier({
                        ThemeProvider().configure()
                    }))
                    
                Spacer()
            }
        }
    }
}
