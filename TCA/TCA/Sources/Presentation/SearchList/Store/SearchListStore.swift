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

enum SearchListAction: Equatable {
  case requestSearchItemList(String)
  case responseSearchItemList(Result<[SearchItem], Never>)
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
      .catchToEffect(SearchListAction.responseSearchItemList)
  case let .responseSearchItemList(.success(searchItemList)):
    state.searchItemList = searchItemList
    return .none
  case .responseSearchItemList(.failure):
    state.searchItemList = []
    return .none
  }
}
