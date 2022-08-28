//
//  ProfileContainerViewStore.swift
//  TCAUITests
//
//  Created by sean on 2022/06/06.
//  Copyright © 2022 butterfree. All rights reserved.
//

import AppCore

import Combine
import Foundation

import ComposableArchitecture

struct ProfileContainerState: Equatable {
  var userInfo: UserInfo?
  var contributions: [Contribution] = []
  var isPresentSignInView: Bool = false
  var isPresentAlert: Bool = false
}

enum ProfileContainerAction: Equatable {
  case onAppear
  case updateUserInfo(UserInfo)
  case updateContributions([Contribution])
  case routeSignInView(RoutingState)
  case routeErrorAlert(RoutingState)
}

struct ProfileContainerEnvironment {
  let userService: UserService
  let provider: ContributionProvider
  
  init(userService: UserService) {
    self.userService = userService
    self.provider = .init(userName: userService.userInfo?.name ?? "")
  }
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
    
    let contributions = environment.provider.contributions()
      .replaceError(with: [])
      .flatMap(maxPublishers: .max(1)) { contributons -> Effect<ProfileContainerAction, Never> in
        return .init(value: .updateContributions(contributons))
      }.eraseToEffect()
    
    return contributions
  case let .updateContributions(contributions):
    state.contributions = contributions
    return .none
  case let .routeSignInView(routingState):
    state.isPresentSignInView = (routingState == .present)
    return .none
  case let .routeErrorAlert(routingState):
    state.isPresentAlert = (routingState == .present)
    return .none
  }
}
