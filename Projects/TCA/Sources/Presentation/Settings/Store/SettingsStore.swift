//
//  SettingsStore.swift
//  TCA
//
//  Created by sean on 2022/08/08.
//

import AppCore

import Combine
import Foundation

import ComposableArchitecture

struct SettingsState: Equatable {
  var isPresentSignOutAlert: Bool = false
  var networkError: NetworkError? = nil
  var isPresentSignInAlert: Bool = false
}

enum SettingsAction: Equatable {
case requestSignOut
case responseSignOut(Result<Bool, URLError>)
case routeSignOutAlert(RoutingState)
case routeErrorAlert(NetworkError?)
}

struct SettingsEnvironment {
  let userService: UserService
  let signOutUseCase: SignOutUseCase
  let mainQueue: AnySchedulerOf<DispatchQueue>
}

let settingsReducer = Reducer<
  SettingsState,
  SettingsAction,
  SettingsEnvironment
> { state, action, environment in
  switch action {
  case .requestSignOut:
    return environment.signOutUseCase.signOut()
      .catchToEffect(SettingsAction.responseSignOut)
  case .responseSignOut(.success):
    environment.userService.signOut()
    return .init(value: .routeSignOutAlert(.present))
  case let .responseSignOut(.failure(error)):
    environment.userService.signOut()
    return .init(value: .routeErrorAlert(.error(error)))
  case let .routeSignOutAlert(routingState):
    state.isPresentSignInAlert = (routingState == .present)
    return .none
    
  case let .routeErrorAlert(error):
    state.networkError = error
    return .none
  }
}
