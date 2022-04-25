//
//  SearchListStore.swift
//  TCA
//
//  Created by sean on 2022/04/24.
//

import Foundation

import ComposableArchitecture

struct SearchListState: Equatable {
  var searchItemList: [SearchItem] = []
}

enum SearchListAction {
  case requestSearchItemList(String)
  case updateSearchItemList([SearchItem])
}

struct SearchListEnvironment {
  let searchUseCase: SearchUseCase
  let mainQueue: AnySchedulerOf<DispatchQueue>
}

let searchListReducer = Reducer<
  SearchListState,
  SearchListAction,
  SearchListEnvironment
> { state, action, environment in
  switch action {
  case let .requestSearchItemList(query):
    return environment.searchUseCase.repositoryList(query: query)
      .receive(on: environment.mainQueue)
      .map { SearchListAction.updateSearchItemList($0) }
      .assertNoFailure()
      .eraseToEffect()
  case let .updateSearchItemList(searchItemList):
    state.searchItemList = searchItemList
    return .none
  }
}
