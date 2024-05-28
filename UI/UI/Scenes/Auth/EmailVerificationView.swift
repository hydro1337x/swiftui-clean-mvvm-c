//
//  EmailVerificationView.swift
//  UI
//
//  Created by Benjamin Mecanović on 18.12.2022..
//

import SwiftUI

struct EmailVerificationView: View {
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: "envelope")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(.accent))
                .frame(width: 100)
            VStack(alignment: .leading, spacing: 0) {
                Text("Verifying email...")
                    .foregroundColor(Color.white)
                    .font(.monserrat(.bold, 32))
                Text("We are verifying your email address. Thank you for your patience!")
                    .foregroundColor(Color.white)
                    .font(.monserrat(.medium, 14))
                    .padding(.top, 30)
            }
            .padding(.top, 40)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 25)
        .background(Color(.background))
    }
}

struct EmailVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerificationView()
            .modifier(OnLoadViewModifier {
                ThemeProvider().configure()
            })
    }
}
