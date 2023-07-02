//
//  SignInStore.swift
//  TCA
//
//  Created by sean on 2022/05/02.
//

import Core

import Combine
import Foundation

import ComposableArchitecture

struct SignInState: Equatable {
  var accessToken: String = ""
  var networkError: NetworkError? = nil
  var isPresentSignInAlert: Bool = false
}

enum SignInAction: Equatable {
  case requestSignIn
  case responseAccessToken(Result<String, URLError>)
  case responseUserInfo(Result<UserInfo, URLError>)
  case routeSignInAlert(RoutingState)
  case routeErrorAlert(NetworkError?)
}

struct SignInEnvironment {
  var userService: UserService
  let signInUseCase: SignInUseCase
  let mainQueue: AnySchedulerOf<DispatchQueue>
}

let signInReducer = Reducer<
  SignInState,
  SignInAction,
  SignInEnvironment
> { state, action, environment in
  switch action {
  case .requestSignIn:
    return environment.signInUseCase.accessToken()
      .catchToEffect(SignInAction.responseAccessToken)
    
  case let .responseAccessToken(.success(accessToken)):
    environment.userService.updateAccessToken(accessToken)
    state.accessToken = accessToken
    return environment.signInUseCase.userInfo(
      accessToken: accessToken
    )
    .receive(on: environment.mainQueue)
    .catchToEffect(SignInAction.responseUserInfo)
    
  case let .responseUserInfo(.success(userInfo)):
    environment.userService.updateUserInfo(userInfo)
    return .init(value: .routeSignInAlert(.present))
    
  case let .responseAccessToken(.failure(error)),
    let .responseUserInfo(.failure(error)):
    environment.userService.signOut()
    state.accessToken = ""
    return .init(value: .routeErrorAlert(.error(error)))
    
  case let .routeSignInAlert(routingState):
    state.isPresentSignInAlert = (routingState == .present)
    return .none
    
  case let .routeErrorAlert(error):
    state.networkError = error
    return .none
  }
}
