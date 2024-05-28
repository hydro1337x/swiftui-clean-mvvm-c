//
//  IfLetView.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 06.11.2022..
//

import SwiftUI

struct IfLetView<Content: View>: View {
    let content: () -> Content?
    
    var body: some View {
        if let content = content() {
            content
        } else {
            EmptyView()
        }
    }
}
