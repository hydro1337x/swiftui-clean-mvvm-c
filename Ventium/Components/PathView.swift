//
//  PathView.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 24.02.2023..
//

import SwiftUI

/// PathView does not have a stable hash value
struct PathView: View, Hashable {
    private let content: AnyView
    private let id = UUID()
    
    init(_ content: some View) {
        self.content = AnyView(content)
    }
    
    var body: some View {
        content
    }
    
    static func == (lhs: PathView, rhs: PathView) -> Bool {
        rhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
