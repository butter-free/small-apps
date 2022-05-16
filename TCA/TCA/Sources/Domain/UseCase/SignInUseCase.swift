//
//  SignInUseCase.swift
//  TCA
//
//  Created by sean on 2022/05/02.
//

import Combine
import Foundation

protocol SignInUseCase {
  func accessToken() -> AnyPublisher<String, URLError>
  func userInfo(accessToken: String) -> AnyPublisher<UserInfo, URLError>
}
