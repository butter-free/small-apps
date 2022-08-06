//
//  RepositoryListStoreTests.swift
//  TCATests
//
//  Created by sean on 2022/03/08.
//

@testable import TCA

import XCTest

import Combine
import ComposableArchitecture

class RepositoryListStoreTests: XCTestCase {
  
  /// Response Success.
  func testRepositoryItemListState_whenRequestItemListActionOnSearchListViewType_thenIsUpdated() {
    
    let scheduler = DispatchQueue.test
    
    let expectState: [RepositoryItem] = [.init(repositoryName: "swift")]
    
    let store = makeTestStore(
      initialState: .init(
        repositoryItemList: [.init(repositoryName: "swift")]
      ),
      viewType: .searchList,
      scheduler: scheduler
    )
    
    store.send(.requestItemList)
    
    store.receive(.requestRepositoryItemList("swift"))
    
    scheduler.advance()
    store.receive(
      .responseRepositoryItemList(.success(expectState))
    ) {
      $0.repositoryItemList = expectState
    }
  }
  
  func testRepositoryItemListState_whenRequestItemListActionOnStarredListViewType_thenIsTrue() {
    
    let scheduler = DispatchQueue.test
    
    let store = makeTestStore(
      initialState: .init(
        repositoryItemList: [.init(repositoryName: "swift")]
      ),
      viewType: .starredList,
      userService: UserManagerStub(userInfo: .init(name: "user")),
      scheduler: scheduler
    )
    
    store.send(.requestItemList)
    scheduler.advance()
    
    store.receive(.requestStarredItemList)
    scheduler.advance()
    
    store.receive(.responseRepositoryItemList(.success([.init(isStarred: true)]))) {
      $0.repositoryItemList = [.init(isStarred: true)]
    }
  }
  
  func testIsPresentSignInViewState_whenRequestItemListActionOnStarredListViewType_thenIsTrue() {
    
    let scheduler = DispatchQueue.test
    
    let store = makeTestStore(
      initialState: .init(
        repositoryItemList: [.init(repositoryName: "swift")]
      ),
      viewType: .starredList,
      scheduler: scheduler
    )
    
    store.send(.requestItemList)
    
    store.receive(.requestStarredItemList)
    store.receive(.routeSignInView(.present)) {
      $0.isPresentSignInView = true
    }
  }

  func testRepositoryItemListState_whenRequestStarActionOnSearchListViewType_thenUpdated() {
    let scheduler = DispatchQueue.test
    
    let store = makeTestStore(
      initialState: .init(
        repositoryItemList: [.init(id: 1)]
      ),
      viewType: .searchList,
      userService: UserManagerStub(isSignIn: true),
      scheduler: scheduler
    )
    
    store.send(.requestStar(.init(id: 1)))
    
    scheduler.advance()
    
    store.receive(.responseStar(.success(.starred(1)))) {
      $0.repositoryItemList[0] = .init(id: 1, isStarred: true)
    }
  }
  
  func testRepositoryItemListState_whenRequestStarActionOnStarredListViewType_thenUpdated() {
    let scheduler = DispatchQueue.test
    
    let store = makeTestStore(
      initialState: .init(
        repositoryItemList: [.init(id: 1)]
      ),
      viewType: .starredList,
      userService: UserManagerStub(isSignIn: true),
      scheduler: scheduler
    )
    
    store.send(.requestStar(.init(id: 1)))
    
    scheduler.advance()
    
    store.receive(.responseStar(.success(.unstar(1)))) {
      $0.repositoryItemList = []
    }
  }
  
  func testIsRouteInViewState_whenRequestStarActionOnIsUserNotSignIn_thenIsTrue() {
    let scheduler = DispatchQueue.test
    
    let store = makeTestStore(
      scheduler: scheduler
    )
    
    store.send(.requestStar(.init(id: 1)))
    
    scheduler.advance()
    
    store.receive(.routeSignInView(.present)) {
      $0.isPresentSignInView = true
    }
  }
  
  /// Response Failed.
  func testRouteErrorAlertState_whenRequestRepositoryItemListAction_thenIsTrue() {
    let scheduler = DispatchQueue.test
    
    let store = makeTestStore(
      isSearchRequestFailed: true,
      scheduler: scheduler
    )
    
    store.send(.requestRepositoryItemList(""))
    
    scheduler.advance()
    
    store.receive(.responseRepositoryItemList(.failure(URLError(.cancelled))))
    
    store.receive(.routeErrorAlert(.present)) {
      $0.isPresentErrorAlert = true
    }
  }
  
  func testRouteErrorAlertState_whenRequestStarredItemListActionOnExistsUserName_thenIsTrue() {
    let scheduler = DispatchQueue.test
    
    let store = makeTestStore(
      userService: UserManagerStub(
        userInfo: .init(name: "user")
      ),
      isStarredRequestFailed: true,
      scheduler: scheduler
    )
    
    store.send(.requestStarredItemList)
    
    scheduler.advance()
    
    store.receive(.responseRepositoryItemList(.failure(URLError(.cancelled))))
    
    store.receive(.routeErrorAlert(.present)) {
      $0.isPresentErrorAlert = true
    }
  }
  
  func testRouteErrorAlertState_whenRequestStarActionOnUserIsSignIn_thenIsTrue() {
    let scheduler = DispatchQueue.test
    
    let store = makeTestStore(
      userService: UserManagerStub(
        isSignIn: true
      ),
      isStarredRequestFailed: true,
      scheduler: scheduler
    )
    
    store.send(.requestStar(.init()))
    
    scheduler.advance()
    
    store.receive(.responseStar(.failure(URLError(.cancelled))))
    
    store.receive(.routeErrorAlert(.present)) {
      $0.isPresentErrorAlert = true
    }
  }
}

extension RepositoryListStoreTests {
  private func makeTestStore(
    initialState: RepositoryListState = .init(),
    viewType: RepositoryListViewType = .none,
    userService: UserService = UserManagerStub(),
    isSearchRequestFailed: Bool = false,
    isStarredRequestFailed: Bool = false,
    scheduler: TestSchedulerOf<DispatchQueue>
  ) -> TestStore<RepositoryListState, RepositoryListState, RepositoryListAction, RepositoryListAction, RepositoryListEnvironment> {
    return .init(
      initialState: initialState,
      reducer: repositoryListReducer,
      environment: RepositoryListEnvironment(
        viewType: viewType,
        userService: userService,
        searchUseCase: SearchDefaultUseCase(
          searchRepository: SearchDataRepository(
            apiService: ApiManagerStub(hasOccerError: isSearchRequestFailed)
          )
        ),
        starredUseCase: StarredDefaultUseCase(
          starredRepository: StarredDataRepository(
            apiService: ApiManagerStub(hasOccerError: isStarredRequestFailed)
          )
        ),
        mainQueue: scheduler.eraseToAnyScheduler()
      )
    )
  }
}
