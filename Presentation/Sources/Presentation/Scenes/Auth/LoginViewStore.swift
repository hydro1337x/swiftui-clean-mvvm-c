//
//  LoginViewStore.swift
//  UI
//
//  Created by Benjamin Mecanović on 25.11.2022..
//

import Foundation

@MainActor
@Observable
public final class LoginViewStore {
    private(set) var isDisabled: Bool = true
    private(set) var email: String = ""
    private(set) var password: String = ""
    private(set) var emailValidationMessage: String?
    private(set) var passwordValidationMessage: String?
    
    let forgotPasswordTitle: String
    let orContinueWithTitle: String
    let registerNowTitle: String
    let enterAsGuestTitle: String
    let loginTitle: String
    
    public var onLogoutButtonTapped: (() -> Void)? = { assertionFailure("LoginViewStore.onLogoutButtonTapped is not implemented.") }
    
    public init() {
        self.forgotPasswordTitle = "Forgot password?"
        self.orContinueWithTitle = "Or continue with"
        self.registerNowTitle = "Register now"
        self.enterAsGuestTitle = "Enter as guest"
        self.loginTitle = "SIGN IN"
    }
    
    func emailChanged(_ email: String) {
        self.email = email
        if !email.isEmpty {
            emailValidationMessage = isEmailValid() ? nil : "Invalid Email"
            isDisabled = !isFormValid()
        }
    }
    
    func passwordChanged(_ password: String) {
        self.password = password
        if !password.isEmpty {
            passwordValidationMessage = isPasswordValid() ? nil : "Invalid Password"
            isDisabled = !isFormValid()
        }
    }
    
    func loginButtonTapped() {
        onLogoutButtonTapped?()
    }
    
    private func isFormValid() -> Bool {
        !password.isEmpty && !email.isEmpty && isEmailValid() && isPasswordValid()
    }
    
    private func isEmailValid() -> Bool {
        email.count > 3
    }
    
    private func isPasswordValid() -> Bool {
        password.count > 3
    }
}
