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
  
  let provider = OAuthProvider(providerID: "github.com")
  
  let userInfoRepository: UserInfoRepository
  
  init(userInfoRepository: UserInfoRepository) {
    self.userInfoRepository = userInfoRepository
  }
}

extension SignInDefaultUseCase {
  
  func accessToken() -> AnyPublisher<String, URLError> {
    
    provider.customParameters = [
      "client_id": Authorization.Github.clientID
    ]
    provider.scopes = ["user:email", "public_repo"]
    
    return provider.getCredentialWith(nil)
      .flatMap {
        return Auth.auth().signIn(with: $0)
          .map { result -> String in
            let credential = result.credential as? OAuthCredential
            return credential?.accessToken ?? ""
          }
          .tryFilter {
            if !$0.isEmpty {
              return true
            } else {
              throw URLError(.badServerResponse)
            }
          }
          .map { "token \($0)" }
      }
      .mapError { _ in
        return URLError(.badServerResponse)
      }
      .eraseToAnyPublisher()
  }
  
  func userInfo(accessToken: String) -> AnyPublisher<UserInfo, URLError> {
    return self.userInfoRepository.requestUserInfo(accessToken: accessToken)
  }
}
