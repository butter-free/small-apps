//
//  SignInDefaultUseCase.swift
//  TCA
//
//  Created by sean on 2022/05/02.
//

import Combine
import Foundation

import FirebaseAuth
import FirebaseAuthCombineSwift

class SignInDefaultUseCase: SignInUseCase {
}

extension SignInDefaultUseCase {
  
  func accessToken() -> AnyPublisher<String, Error> {
    let provider = OAuthProvider(providerID: "github.com")
    provider.customParameters = [
      "client_id": Authorization.Github.clientID
    ]
    provider.scopes = ["user:email"]
    
    return provider.getCredentialWith(nil)
      .flatMap {
        return Auth.auth().signIn(with: $0)
          .map { result -> String in
            let credential = result.credential as? OAuthCredential
            let accessToken = credential?.accessToken ?? ""
            return accessToken
          }.eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }
}
