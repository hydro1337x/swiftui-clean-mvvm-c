//
//  AuthButton.swift
//  UI
//
//  Created by Benjamin Mecanović on 11.12.2022..
//

import SwiftUI

struct AuthButton: View {
    
    let isDisabled: Bool
    let title: String
    let action: () -> Void
    
    var opacity: CGFloat {
        isDisabled ? 0.5 : 1
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.monserrat(.bold, 18))
        }
        .frame(height: 40)
        .padding(.horizontal, 50)
        .foregroundColor(.white)
        .background(Color(.accent))
        .cornerRadius(20)
        .disabled(isDisabled)
        .opacity(opacity)
    }
}

struct AuthButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthButton(isDisabled: false, title: "LOGIN", action: {})
            AuthButton(isDisabled: true, title: "LOGIN", action: {})
        }
        .modifier(OnLoadViewModifier {
            ThemeProvider().configure()
        })   
    }
}
