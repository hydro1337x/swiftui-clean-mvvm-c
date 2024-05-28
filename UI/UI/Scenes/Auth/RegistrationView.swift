//
//  RegistrationView.swift
//  UI
//
//  Created by Benjamin Mecanović on 11.12.2022..
//

import SwiftUI

struct RegistrationView: View {
    var body: some View {
        VStack {
            Spacer()
            TextEntry(text: .constant("Email"), message: nil, placeholder: "")
            TextEntry(text: .constant("Password"), message: nil, placeholder: "", type: .secure)
            TextEntry(text: .constant("Repeated Password"), message: nil, placeholder: "", type: .secure)
            AuthButton(isDisabled: true, title: "REGISTER", action: {})
                .padding(.top, 40)
            Spacer()
        }
        .padding(.horizontal, 25)
        .background(Color(.background))
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .modifier(OnLoadViewModifier {
                ThemeProvider().configure()
            })
    }
}
