//
//  SignInStoreTests.swift
//  TCATests
//
//  Created by sean on 2022/05/17.
//  Copyright © 2022 butterfree. All rights reserved.
//

@testable import TCA

import XCTest

import Combine
import ComposableArchitecture

class SignInStoreTests: XCTestCase {
  
  func testIsPresentSignInAlertState_whenRequestSignInAction_thenIsTrue() {
    
    let scheduler = DispatchQueue.test
    
    let expectState: String = "token"
    
    let store: TestStore<SignInState, SignInState, SignInAction, SignInAction, SignInEnvironment> = .init(
      initialState: .init(),
      reducer: signInReducer,
      environment: .init(
        userService: UserManagerStub(),
        signInUseCase: SignInDefaultUseCaseStub(
          token: "token",
          userInfoRepository: UserInfoDataRepository(
            apiService: ApiManagerStub()
          )
        ),
        mainQueue: scheduler.eraseToAnyScheduler()
      )
    )
    
    store.send(.requestSignIn)
    
    scheduler.advance()
    
    store.receive(.responseAccessToken(.success(expectState))) {
      $0.accessToken = expectState
    }
    
    scheduler.advance()
    
    store.receive(.responseUserInfo(
      .success(store.environment.userService.userInfo!))
    )
    store.receive(.routeSignInAlert(.present)) {
      $0.isPresentSignInAlert = true
    }
    
    XCTAssert(store.environment.userService.accessToken == expectState)
    /// SampleData
    XCTAssert(store.environment.userService.userInfo?.name == "user")
  }
  
  func testNetworkErrorState_whenRequestSignInAction_thenEqualsExpectedError() {
    
    let scheduler = DispatchQueue.test
    
    let expectState: URLError = URLError(.cancelled)
    
    let store: TestStore<SignInState, SignInState, SignInAction, SignInAction, SignInEnvironment> = .init(
      initialState: .init(),
      reducer: signInReducer,
      environment: .init(
        userService: UserManagerStub(),
        signInUseCase: SignInDefaultUseCaseStub(
          token: "token",
          isAccessTokenResponseFailed: true,
          userInfoRepository: UserInfoDataRepository(
            apiService: ApiManagerStub(hasOccerError: true)
          )
        ),
        mainQueue: scheduler.eraseToAnyScheduler()
      )
    )
    
    store.send(.requestSignIn)
    
    scheduler.advance()
    
    store.receive(.responseAccessToken(.failure(expectState))) {
      $0.accessToken = ""
    }
    
    store.receive(.routeErrorAlert(.error(expectState))) {
      $0.networkError = .error(expectState)
    }
    
    XCTAssert(store.environment.userService.isSignIn == false)
  }
}
