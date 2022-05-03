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
  case requestSignIn
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
  case .requestSignIn:
    return environment.signInUseCase.accessToken()
      .receive(on: DispatchQueue.main)
      .catchToEffect(SignInAction.response)
  case let .response(.success(token)):
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

