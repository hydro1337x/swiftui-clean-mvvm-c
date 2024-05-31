//
//  SideMenu.swift
//  UI
//
//  Created by Benjamin Mecanović on 25.02.2023..
//

import SwiftUI

public struct SideMenu: View {
    let actions: SideMenuActions
    
    public init(actions: SideMenuActions) {
        self.actions = actions
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Button(action: actions.onDismissTap) {
                Color.clear
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color(.accent))
                    .background(Color(.accent))
                    .overlay(
                        LinearGradient(colors: [.clear, Color(.background)], startPoint: .leading, endPoint: .trailing)
                    )
            }
            .frame(width: 75)
            
            
            ScrollView {
                VStack(spacing: 10) {
                    Text("Menu")
                        .font(.monserrat(.bold, 32))
                        
                    Divider()
                        .frame(height: 2)

                    Button(action: actions.onLogoutTap) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                .foregroundColor(.white)
                            Text("Logout")
                                .font(.monserrat(.medium, 18))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(height: 44)
                    .background(Color(.accent))
                    .cornerRadius(22)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(.background))
        }
    }
}

public struct SideMenuActions {
  let onLogoutTap: () -> Void
  let onDismissTap: () -> Void
  
  public init(onLogoutTap: @escaping () -> Void, onDismissTap: @escaping () -> Void) {
      self.onLogoutTap = onLogoutTap
      self.onDismissTap = onDismissTap
  }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(actions: .init(onLogoutTap: {}, onDismissTap: {}))
    }
}
