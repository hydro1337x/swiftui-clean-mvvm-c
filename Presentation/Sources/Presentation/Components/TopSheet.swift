//
//  TopSheet.swift
//  UI
//
//  Created by Benjamin Mecanović on 19.12.2022..
//

import SwiftUI

public struct TopSheet: View {
    @State private var height: CGFloat = 0
    
    let isShown: Bool
    let items: [String]
    let actions: TopSheetActions
    
    private let grabberBottomPadding: CGFloat = 5
    private let grabberTopPadding: CGFloat = 15
    private let topPadding: CGFloat = 15
    
    public init(
        isShown: Bool,
        items: [String],
        actions: TopSheetActions
    ) {
        self.isShown = isShown
        self.items = items
        self.actions = actions
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color(.background)
                .opacity(backgroundOpacity)
                .animation(.default, value: isShown)
                .onTapGesture(perform: actions.onBackgroundTap)
                .allowsHitTesting(isShown)
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            actions.onItemSelection(item)
                        }, label: {
                            Text(item)
                                .font(.monserrat(.medium, 16))
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                        })
                        .frame(height: 40)
                    }
                }
                .padding(.top, topPadding)
                
                Color.white
                    .frame(width: 40, height: 4)
                    .cornerRadius(2)
                    .padding(.top, grabberTopPadding)
                    .padding(.bottom, grabberBottomPadding)
            }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .frame(height: height, alignment: .bottom)
            .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
            .simultaneousGesture(
                DragGesture()
                    .onChanged(handleOnDragChanged)
                    .onEnded(handleOnDragEnded)
            )
        }
        .onChange(of: isShown) { _, newValue in
            handleIsShownChanged(newValue)
        }
    }
}

extension TopSheet {
    var backgroundOpacity: CGFloat {
        isShown ? 0.25 : 0
    }
    
    var maxHeight: CGFloat {
        CGFloat(items.count * 40 + 4) + grabberBottomPadding + grabberTopPadding + topPadding
    }
    
    func handleOnDragChanged(_ value: DragGesture.Value) {
        if value.translation.height < 0 {
            withAnimation {
                height = max(0, maxHeight - abs(value.translation.height))
            }
        }
    }
    
    func handleOnDragEnded(_ value: DragGesture.Value) {
        if height < maxHeight * 0.7 {
            actions.onDragEnded()
        } else {
            withAnimation {
                height = maxHeight
            }
        }
    }
    
    func handleIsShownChanged(_ value: Bool) {
        withAnimation {
            height = value ? maxHeight : 0
        }
    }
}

public struct TopSheetActions {
    let onItemSelection: (String) -> Void
    let onBackgroundTap: () -> Void
    let onDragEnded: () -> Void
    
    public init(
        onItemSelection: @escaping (String) -> Void,
        onBackgroundTap: @escaping () -> Void,
        onDragEnded: @escaping () -> Void
    ) {
        self.onItemSelection = onItemSelection
        self.onBackgroundTap = onBackgroundTap
        self.onDragEnded = onDragEnded
    }
}

//struct TopSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        TopSheet(
//            isShown: true,
//            items: ["One", "Two", "Three"],
//            actions: TopSheetActions(
//                onItemSelection: { _ in },
//                onBackgroundTap: {},
//                onDragEnded: {}
//            )
//        )
//            .background(Color.green)
//    }
//}
