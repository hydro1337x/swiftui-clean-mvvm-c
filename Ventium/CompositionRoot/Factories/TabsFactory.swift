//
//  TabsFactory.swift
//  Ventium
//
//  Created by Benjamin Mecanović on 15.12.2022..
//

import SwiftUI
import UI

struct TabsFactory {
  let homeFactory: HomeFactory
  let searchFactory: SearchFactory
  let notificationsFactory: NotificationsFactory
  let profileFactory: ProfileFactory
  
  func makeHomeCoordinator() -> HomeCoordinatorStore {
    return HomeCoordinatorStore(
      factory: homeFactory
    )
  }
  
//  func makeSearchCoordinator() -> SearchCoordinator {
//    SearchCoordinator(factory: searchFactory)
//  }
//  
//  func makeNotificationsCoordinator() -> NotificationsCoordinator {
//    NotificationsCoordinator(factory: notificationsFactory)
//  }
//  
//  func makeProfileCoordinator() -> ProfileCoordinator {
//    return ProfileCoordinator(
//      factory: profileFactory
//    )
//  }
}
