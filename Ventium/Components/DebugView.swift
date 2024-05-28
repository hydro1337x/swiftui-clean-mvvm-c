//
//  DebugView.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 11.03.2023..
//

import SwiftUI

struct DebugView: View {
    @State private var isReachableToggle = true
    
    let actions: Actions
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                HStack {
                    Spacer()
                    Text("Debug View")
                    Spacer()
                    Button(action: actions.onDismiss) {
                        Image(systemName: "xmark")
                            .resizable()
                            .padding(8)
                            .frame(width: 40 , height: 40)
                    }
                }
                .padding(.bottom, 25)
                
                HStack {
                    Text("Reachability")
                    Toggle(isOn: $isReachableToggle, label: { EmptyView() })
                    Button("Send") {
                        actions.onReachabilityChange(isReachableToggle)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                HStack {
                    Text("Toast")
                    Spacer()
                    Button("Send") {
                        actions.onToastSend("Simulated Toast Message!")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding(8)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(8)
        .padding(16)
    }
}

extension DebugView {
    struct Actions {
        let onReachabilityChange: (Bool) -> Void
        let onToastSend: (String) -> Void
        let onDismiss: () -> Void
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView(actions: .init(onReachabilityChange: { _ in }, onToastSend: { _ in }, onDismiss: {}))
    }
}
