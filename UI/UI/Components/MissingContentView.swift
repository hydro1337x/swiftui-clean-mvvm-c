//
//  MissingContentView.swift
//  UI
//
//  Created by Benjamin Mecanović on 06.03.2023..
//

import SwiftUI

struct MissingContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "menucard.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(.accent))
                .frame(width: 100, height: 100)
            
            Text("Nothing to show for now...")
                .foregroundColor(.white)
                .font(.monserrat(.medium, 24))
        }
    }
}

struct MissingContentView_Previews: PreviewProvider {
    static var previews: some View {
        MissingContentView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.background))
    }
}
