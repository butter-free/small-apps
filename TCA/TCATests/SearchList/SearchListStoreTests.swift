//
//  SearchListStoreTests.swift
//  TCATests
//
//  Created by sean on 2022/03/08.
//

import Combine
import ComposableArchitecture
import XCTest
@testable import TCA

class SearchListStoreTests: XCTestCase {
  
  let scheduler = DispatchQueue.test
  
  var store: TestStore<SearchListState, SearchListState, SearchListAction, SearchListAction, SearchListEnvironment>?
  
  override func setUp() {
    super.setUp()
    
    store = TestStore(
      initialState: .init(),
      reducer: searchListReducer,
      environment: SearchListEnvironment(
        searchUseCase: SearchDefaultUseCase(
          repository: SearchDataRepository(
            apiService: ApiManagerStub()
          )
        ),
        mainQueue: scheduler.eraseToAnyScheduler()
      )
    )
  }
  
  override func tearDown() {
    super.tearDown()
    
    store = nil
  }
  
  func testState_whenRequestSearchItemListAction_thenIsNotEmpty() {
    
    let expectState: [SearchItem] = [.init(updatedDate: "Updated in 8 hours")]
    
    store?.send(.requestSearchItemList(""))
    
    scheduler.advance()
    store?.receive(.responseSearchItemList(.success(expectState))) {
      $0.searchItemList = expectState
    }
  }
}
