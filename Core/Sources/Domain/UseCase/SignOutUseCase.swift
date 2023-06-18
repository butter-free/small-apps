//
//  SignOutUseCase.swift
//  TCA
//
//  Created by sean on 2022/08/08.
//

import Combine
import Foundation

public protocol SignOutUseCase {
  func signOut() -> AnyPublisher<Bool, URLError>
}
