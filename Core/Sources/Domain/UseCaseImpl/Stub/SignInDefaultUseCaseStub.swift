//
//  SignInDefaultUseCaseStub.swift
//  TCATests
//
//  Created by sean on 2022/05/25.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Combine
import Foundation

final class SignInDefaultUseCaseStub: SignInUseCase {
  
  let token: String
  let isAccessTokenResponseFailed: Bool
  let userInfoRepository: UserInfoRepository
  
  init(
    token: String,
    isAccessTokenResponseFailed: Bool = false,
    userInfoRepository: UserInfoRepository
  ) {
    self.token = token
    self.isAccessTokenResponseFailed = isAccessTokenResponseFailed
    self.userInfoRepository = userInfoRepository
  }
}

extension SignInDefaultUseCaseStub {
  func accessToken() -> AnyPublisher<String, URLError> {
    
    if isAccessTokenResponseFailed {
      return Fail(error: URLError(.cancelled)).eraseToAnyPublisher()
    }
    
    return Just<String>(token)
      .setFailureType(to: URLError.self)
      .eraseToAnyPublisher()
  }
  
  func userInfo(accessToken: String) -> AnyPublisher<UserInfo, URLError> {
    return self.userInfoRepository.requestUserInfo(
      accessToken: accessToken
    )
  }
}
