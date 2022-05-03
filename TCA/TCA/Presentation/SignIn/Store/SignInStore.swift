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
  var networkError: NetworkError? = nil
  var isShowErrorAlert: Bool = false
}

enum SignInAction {
  case requestGithubSignIn
  case updateToken(String)
  case response(Result<String, Error>)
  case dismissErrorAlert
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
    return environment.signInUseCase.accessToken()
      .receive(on: DispatchQueue.main)
      .map { SignInAction.updateToken($0) }
      .eraseToEffect()
  case let .updateToken(token):
      .catchToEffect(SignInAction.response)
    state.token = token
    return .none
  case let .response(.failure(error)):
    state.networkError = .error(error)
    state.isShowErrorAlert = true
    return .none
  case .dismissErrorAlert:
    state.networkError = nil
    state.isShowErrorAlert = false
    return .none
  }
}

