//
//  SignOutDefaultUseCase.swift
//  TCA
//
//  Created by sean on 2022/08/08.
//

import Combine
import Foundation

import FirebaseAuth
import FirebaseAuthCombineSwift

public final class SignOutDefaultUseCase: SignOutUseCase {
  
  public init() {}
  
  public func signOut() -> AnyPublisher<Bool, URLError> {
    do {
      try Auth.auth().signOut()
      return Just(true)
        .setFailureType(to: URLError.self).eraseToAnyPublisher()
    } catch let error {
      print(error.localizedDescription)
    }
    
    return Just(false)
      .setFailureType(to: URLError.self).eraseToAnyPublisher()
  }
}
