//
//  Toast.swift
//  UI
//
//  Created by Benjamin Mecanović on 10.03.2023..
//

import SwiftUI

public struct Toast: View {
    let message: String
    
    public init(message: String) {
        self.message = message
    }
    
    public var body: some View {
        HStack {
            Text(message)
                .font(.monserrat(.medium, 14))
                .padding(8)
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(.thinMaterial)
        .cornerRadius(5)
    }
}

struct NetworkToast_Previews: PreviewProvider {
    static var previews: some View {
        Toast(message: "Network appears to be offline")
            .padding(.horizontal, 20)
    }
}
