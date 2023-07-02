//
//  RepositoryListStore.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Core

import Combine
import Foundation

import ComposableArchitecture

enum RoutingState: Equatable {
  case present, dismiss
}

enum RequestStarState: Equatable {
  case starred(RepositoryItem), unstar(RepositoryItem)
}

struct RepositoryListState: Equatable {
  var repositoryItemList: [RepositoryItem] = []
  var isPresentAlert: Bool = false
  var isPresentSignInView: Bool = false
  var isPresentErrorAlert: Bool = false
}

enum RepositoryListAction: Equatable {
  case requestItemList
  
  case requestStarredItemList
  case requestStar(RepositoryItem)
  case responseStar(Result<ResponseStarState, URLError>)
  
  case requestRepositoryItemList(String)
  case responseRepositoryItemList(Result<[RepositoryItem], URLError>)
  
  case routeSignInView(RoutingState)
  case routeErrorAlert(RoutingState)
}

struct RepositoryListEnvironment {
  let viewType: RepositoryListViewType
  let userService: UserService
  let searchUseCase: SearchUseCase
  let starredUseCase: StarredUseCase
  let mainQueue: AnySchedulerOf<DispatchQueue>
}

let repositoryListReducer = Reducer<
  RepositoryListState,
  RepositoryListAction,
  RepositoryListEnvironment
> { state, action, environment in
  switch action {
  case .requestItemList:
    if environment.viewType == .search {
      return .init(value: .requestRepositoryItemList("swift"))
    } else {
      return .init(value: .requestStarredItemList)
    }
    
  case let .requestRepositoryItemList(query):
    return environment.searchUseCase.repositoryList(query: query)
      .receive(on: environment.mainQueue)
      .catchToEffect(RepositoryListAction.responseRepositoryItemList)
  
  case .requestStarredItemList:
    
    guard let ownerName = environment.userService.userInfo?.name else {
      return .init(value: .routeSignInView(.present))
    }
    
    return environment.starredUseCase.repositoryList(
      ownerName: ownerName
    )
    .receive(on: environment.mainQueue)
    .catchToEffect(RepositoryListAction.responseRepositoryItemList)
    
  case let .responseRepositoryItemList(result):
    switch result {
    case let .success(repositoryItemList):
      state.repositoryItemList = repositoryItemList
    case .failure:
      return .init(value: .routeErrorAlert(.present))
    }
    return .none
    
  case let .requestStar(item):
    if environment.userService.isSignIn {
      
      let requestState: RequestStarState = environment.viewType == .search ? .starred(item) : .unstar(item)
      
      switch requestState {
      case let .starred(item):
        let (id, ownerName, repositoryName) = (
          item.id,
          item.owner.name,
          item.repositoryName
        )
        
        return environment.starredUseCase.starred(
          id: id,
          ownerName: ownerName,
          repositoryName: repositoryName
        )
        .receive(on: environment.mainQueue)
        .catchToEffect(RepositoryListAction.responseStar)
      case let .unstar(item):
        let (id, ownerName, repositoryName) = (
          item.id,
          item.owner.name,
          item.repositoryName
        )
        
        return environment.starredUseCase.unStar(
          id: id,
          ownerName: ownerName,
          repositoryName: repositoryName
        )
        .receive(on: environment.mainQueue)
        .catchToEffect(RepositoryListAction.responseStar)
      }
    } else {
      return .init(value: .routeSignInView(.present))
    }
    
  case let .responseStar(result):
    switch result {
    case let .success(starState):
      var repositoryItemList = state.repositoryItemList
      
      switch starState {
      case let .starred(id):
        repositoryItemList.enumerated().forEach { offset, element in
          if element.id == id {
            repositoryItemList[offset].isStarred = true
          }
        }
        state.repositoryItemList = repositoryItemList
      case let .unstar(id):
        state.repositoryItemList = repositoryItemList.filter {
          $0.id != id
        }
      }
    case .failure:
      return .init(value: .routeErrorAlert(.present))
    }
    return .none
    
  case let .routeSignInView(routingState):
    state.isPresentSignInView = (routingState == .present)
    return .none

  case let .routeErrorAlert(routingState):
    state.isPresentErrorAlert = (routingState == .present)
    return .none
  }
}
