//
//  ForgotPasswordView.swift
//  UI
//
//  Created by Benjamin Mecanović on 11.12.2022..
//

import SwiftUI

struct ForgotPasswordView: View {
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: "lock")
                .resizable()
                .foregroundColor(Color(.accent))
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 0) {
                Text("Forgot password?")
                    .foregroundColor(Color.white)
                    .font(.monserrat(.bold, 32))
                Text("Don't worry! It happens. Please enter the email address associated with your account.")
                    .foregroundColor(Color.white)
                    .font(.monserrat(.medium, 14))
                    .padding(.top, 30)
            }
            .padding(.top, 40)
            TextEntry(text: .constant("Email"), message: nil, placeholder: "")
            AuthButton(isDisabled: true, title: "PROCEED", action: {})
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 25)
        .background(Color(.background))
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .modifier(OnLoadViewModifier {
                ThemeProvider().configure()
            })
    }
}
