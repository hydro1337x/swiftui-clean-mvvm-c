//
//  DualDatePicker.swift
//  UI
//
//  Created by Benjamin Mecanović on 28.12.2022..
//

import SwiftUI

public struct DualDatePicker: View {
    @Binding var components: Set<DateComponents>
    @State private var buffer: [DateComponents] = []
    
    public init(components: Binding<Set<DateComponents>>) {
        self._components = components
    }
    
    public var body: some View {
        MultiDatePicker("Dual Date Picker", selection: $components)
            .onChange(of: components) { components in
                DispatchQueue.main.async {
                    handleComponents(components)
                }
            }
    }
    
    func handleComponents(_ components: Set<DateComponents>) {
        if components.count > buffer.count {
            // Addition
            handleAddition(components)
        }
    }
    
    // TODO: - Investigate if having a function scoped temp variable would mitigate the micro-stutters caused by DQ.async
    private func handleAddition(_ components: Set<DateComponents>) {
        if components.count == 1 {
            buffer = Array(components)
        } else if components.count == 2 {
            let bufferSet = Set(buffer)
            guard let newElement = components.subtracting(bufferSet).first else { return }
            buffer.append(newElement)
        } else {
            let bufferSet = Set(buffer)
            guard let newElement = components.subtracting(bufferSet).first else { return }
            
            let oldest = buffer[0]
            buffer.append(newElement)
            buffer.remove(at: 0)
            self.components.remove(oldest)
        }
    }
}

struct DualDatePicker_Previews: PreviewProvider {
    @State private static var components: Set<DateComponents> = []
    
    static var previews: some View {
        DualDatePicker(components: $components)
    }
}
