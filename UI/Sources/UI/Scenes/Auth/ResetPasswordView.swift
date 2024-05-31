//
//  ResetPasswordView.swift
//  UI
//
//  Created by Benjamin Mecanović on 18.12.2022..
//

import SwiftUI

struct ResetPasswordView: View {
    var body: some View {
        VStack {
            Spacer()
            TextEntry(text: .constant("Password"), message: nil, placeholder: "", type: .secure)
            TextEntry(text: .constant("Repeated Password"), message: nil, placeholder: "", type: .secure)
            AuthButton(isDisabled: true, title: "RESET", action: {})
                .padding(.top, 40)
            Spacer()
        }
        .padding(.horizontal, 25)
        .background(Color(.background))
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
            .modifier(OnLoadViewModifier {
                ThemeProvider().configure()
            })
    }
}
