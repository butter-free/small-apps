//
//  ProfileContainerStoreTests.swift
//  TCAUITests
//
//  Created by sean on 2022/06/07.
//  Copyright © 2022 butterfree. All rights reserved.
//

@testable import TCA

import XCTest

import Combine
import ComposableArchitecture

class ProfileContainerStoreTests: XCTestCase {
  
  func testUserInfoState_whenOnAppearActionOnUserInfoNotNil_thenIsUpdated() {
    
    let expectState: UserInfo = .init()
    
    let store: TestStore<ProfileContainerState, ProfileContainerState, ProfileContainerAction, ProfileContainerAction, ProfileContainerEnvironment> = .init(
      initialState: .init(),
      reducer: profileContainerReducer,
      environment: .init(
        userService: UserManagerStub(
          userInfo: expectState
        )
      )
    )
    
    store.send(.onAppear)
    
    store.receive(.updateUserInfo(expectState)) {
      $0.userInfo = expectState
    }
  }
  
  func testIsPresentSignInViewState_whenOnAppearActionOnUserInfoNil_thenIsTrue() {
    
    let store: TestStore<ProfileContainerState, ProfileContainerState, ProfileContainerAction, ProfileContainerAction, ProfileContainerEnvironment> = .init(
      initialState: .init(),
      reducer: profileContainerReducer,
      environment: .init(
        userService: UserManagerStub(
          userInfo: nil
        )
      )
    )
    
    store.send(.onAppear)
    
    store.receive(.routeSignInView(.present)) {
      $0.isPresentSignInView = true
    }
  }
}
