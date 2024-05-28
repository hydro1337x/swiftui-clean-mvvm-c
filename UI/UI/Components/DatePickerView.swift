//
//  DatePickerView.swift
//  UI
//
//  Created by Benjamin Mecanović on 31.12.2022..
//

import SwiftUI

public struct DatePickerView: View {
    @State private var components: Set<DateComponents> = []
    
    let onSubmit: (Set<DateComponents>) -> Void
    let buttonTitle: String
    
    public init(onSubmit: @escaping (Set<DateComponents>) -> Void, buttonTitle: String) {
        self.onSubmit = onSubmit
        self.buttonTitle = buttonTitle
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            DualDatePicker(components: $components)
            Button(action: {
                onSubmit(components)
            }) {
                Text(buttonTitle)
                    .font(.monserrat(.bold, 18))
            }
            .frame(height: 40)
            .padding(.horizontal, 50)
            .foregroundColor(.white)
            .background(Color(.accent))
            .cornerRadius(20)
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(onSubmit: { _ in }, buttonTitle: "Submit")
            .modifier(OnLoadViewModifier({
                ThemeProvider().configure()
            }))
    }
}
