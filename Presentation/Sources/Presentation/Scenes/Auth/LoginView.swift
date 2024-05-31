//
//  LoginView.swift
//  UI
//
//  Created by Benjamin Mecanović on 25.11.2022..
//

import SwiftUI

public struct LoginView: View {
    let store: LoginViewStore
    
    public init(store: LoginViewStore) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 20) {
                TextEntry(
                    text: .bind(store.email, with: { store.emailChanged($0) }),
                    message: store.emailValidationMessage,
                    placeholder: "Email"
                )
                TextEntry(
                    text: .bind(store.password, with: { store.passwordChanged($0) }),
                    message: store.passwordValidationMessage,
                    placeholder: "Password",
                    type: .secure
                )
            }
            .padding(.horizontal, 25)
            
            HStack {
                Spacer()
                Button(action: {}) {
                    Text(store.forgotPasswordTitle)
                        .font(.monserrat(.medium, 14))
                        .foregroundColor(Color(.foregroundSecondary))
                }
            }
            .padding(.horizontal, 25)
            .padding(.top, 15)
            
            AuthButton(
                isDisabled: store.isDisabled,
                title: store.loginTitle,
                action: store.loginButtonTapped
            )
            .padding(.top, 40)
            
            Text(store.orContinueWithTitle)
                .foregroundColor(Color(.foregroundSecondary))
                .font(.monserrat(.medium, 14))
                .padding(.top, 40)
            HStack(spacing: 20) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 44, height: 44)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 44, height: 44)
            }
            .padding(.top, 15)
            
            Spacer()
            
            VStack(spacing: 15) {
                Text(store.registerNowTitle)
                    .font(.monserrat(.medium, 14))
                    .foregroundColor(Color(.accent))
                Text(store.enterAsGuestTitle)
                    .font(.monserrat(.medium, 14))
                    .foregroundColor(Color(.accent))
            }
        }
        .background(Color(.background))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: LoginViewStore())
    }
}
