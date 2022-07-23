//
//  ProfileContainerViewStore.swift
//  TCAUITests
//
//  Created by sean on 2022/06/06.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Combine
import Foundation

import ComposableArchitecture

struct ProfileContainerState: Equatable {
  var userInfo: UserInfo?
  var isPresentSignInView: Bool = false
}

enum ProfileContainerAction: Equatable {
  case onAppear
  case updateUserInfo(UserInfo)
  case routeSignInView(RoutingState)
}

struct ProfileContainerEnvironment {
  let userService: UserService
}

let profileContainerReducer = Reducer<
  ProfileContainerState,
  ProfileContainerAction,
  ProfileContainerEnvironment
> { state, action, environment in
  switch action {
  case .onAppear:
    
    if let userInfo = environment.userService.userInfo {
      return .init(value: .updateUserInfo(userInfo))
    }
    
    return .init(value: .routeSignInView(.present))
  case let .updateUserInfo(userInfo):
    state.userInfo = userInfo
    return .none
  case let .routeSignInView(routingState):
    state.isPresentSignInView = (routingState == .present)
    return .none
  }
}
