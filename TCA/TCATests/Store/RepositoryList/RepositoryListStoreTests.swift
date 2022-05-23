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
  
  func testRepositoryItemListState_whenRequestItemListActionOnSearchListViewType_thenIsUpdated() {
    
    let expectState: [RepositoryItem] = [.init(repositoryName: "swift")]
    let scheduler = DispatchQueue.test
    
    let store = TestStore(
      initialState: .init(
        repositoryItemList: [.init(repositoryName: "swift")]
      ),
      reducer: repositoryListReducer,
      environment: RepositoryListEnvironment(
        viewType: .searchList,
        userService: UserManager.shared,
        searchUseCase: SearchDefaultUseCase(
          searchRepository: SearchDataRepository(
            apiService: ApiManagerStub()
          )
        ),
        starredUseCase: StarredDefaultUseCase(
          starredRepository: StarredDataRepository()
        ),
        mainQueue: scheduler.eraseToAnyScheduler()
      )
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
  
  func testIsPresentSignInViewState_whenRequestItemListActionOnStarredListViewType_thenIsTrue() {
    
    let scheduler = DispatchQueue.test
    
    let store = TestStore(
      initialState: .init(),
      reducer: repositoryListReducer,
      environment: RepositoryListEnvironment(
        viewType: .starredList,
        userService: UserManager.shared,
        searchUseCase: SearchDefaultUseCase(
          searchRepository: SearchDataRepository(
            apiService: ApiManagerStub()
          )
        ),
        starredUseCase: StarredDefaultUseCase(
          starredRepository: StarredDataRepository()
        ),
        mainQueue: scheduler.eraseToAnyScheduler()
      )
    )
    
    scheduler.advance()
    
    store.send(.requestItemList)
    
    scheduler.advance()
    
    store.receive(.requestStarredItemList)
    
    
    store.receive(.routeSignInView(.present)) {
      $0.isPresentSignInView = true
    }
  }
}
