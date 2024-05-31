//
//  TextEntry.swift
//  UI
//
//  Created by Benjamin Mecanović on 16.11.2022..
//

import SwiftUI

enum EntryType {
    case plain
    case secure
}

public struct TextEntry: View {
    @Binding var text: String
    @State private var isSecure = false
    @FocusState private var isFocused: Bool
    
    let message: String?
    let placeholder: String
    let type: EntryType
    
    init(
        text: Binding<String>,
        message: String?,
        placeholder: String,
        type: EntryType = .plain
    ) {
        self._text = text
        self.message = message
        self.placeholder = placeholder
        self.type = type
    }
    
    var placeholderYOffset: CGFloat {
        isFocusFilled ? -26 : 0
    }
    
    var placeholderScale: CGFloat {
        isFocusFilled ? 0.9 : 1
    }
    
    var placeholderColor: Color {
        isFocused ? Color(.accent) : Color(.foregroundTertiary)
    }
    
    var separator: Color {
        isFocused ? Color(.accent) : Color(.foregroundTertiary)
    }
    
    var messageScale: CGFloat {
        isValid ? 0 : 1
    }
    
    var isFocusFilled: Bool {
        !text.isEmpty || isFocused
    }
    
    var isValid: Bool {
        message == nil
    }
    
    var imageName: String {
        isSecure ? "eye" : "eye.slash"
    }
    
    @ViewBuilder
    var textField: some View {
        if isSecure {
            SecureField("", text: $text)
        } else {
            TextField("", text: $text)
        }
    }
    
    @ViewBuilder
    var secureToggleView: some View {
        switch type {
        case .secure:
            HStack(spacing: 0) {
                Spacer()
                Button(action: toggleIsSecure) {
                    Image(systemName: imageName)
                        .foregroundColor(.white)
                }
            }
        default:
            EmptyView()
        }
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .leading) {
                Text(placeholder)
                    .font(.monserrat(.medium, 14))
                    .foregroundColor(placeholderColor)
                    .offset(y: placeholderYOffset)
                    .scaleEffect(placeholderScale, anchor: .leading)
                    .animation(.spring(response: 0.4, dampingFraction: 0.4, blendDuration: 0.3), value: isFocusFilled)
                
                textField
                    .font(.monserrat(.medium, 14))
                    .foregroundColor(.white)
                    .frame(height: 40)
                    .focused($isFocused)
                
                secureToggleView
            }
            
            separator
                .frame(height: 1)
            
            HStack {
                Text(message ?? "")
                    .font(.monserrat(.medium, 10))
                    .foregroundColor(Color(.accent))
                Spacer()
            }
            .padding(.top, 1)
            .scaleEffect(y: messageScale)
            .animation(.easeInOut(duration: 0.1), value: messageScale)
        }
    }
    
    func toggleIsSecure() {
        isSecure.toggle()
    }
}

struct TextEntry_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextEntry(text: .constant("Email"), message: nil, placeholder: "", type: .plain)
                .frame(height: 44)
                .padding()
        }
        .background(Color(.background))
        .modifier(OnLoadViewModifier {
            ThemeProvider().configure()
        })
    }
}
