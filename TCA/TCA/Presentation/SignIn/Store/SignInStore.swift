//
//  SignInStore.swift
//  TCA
//
//  Created by sean on 2022/05/02.
//

import Foundation

import ComposableArchitecture

struct SignInState: Equatable {
  var token: String = ""
}

enum SignInAction {
  case requestGithubSignIn
  case updateToken(String)
}

struct SignInEnvironment {
  let signInUseCase: SignInUseCase
}

let signInReducer = Reducer<
  SignInState,
  SignInAction,
  SignInEnvironment
> { state, action, environment in
  switch action {
  case let .requestGithubSignIn:
    return environment.signInUseCase.authorizationToken()
      .receive(on: DispatchQueue.main)
      .map { SignInAction.updateToken($0) }
      .eraseToEffect()
  case let .updateToken(token):
    state.token = token
    return .none
  }
}

