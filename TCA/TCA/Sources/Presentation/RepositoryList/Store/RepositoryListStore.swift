//
//  RepositoryListStore.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

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
  var selectedItem: RepositoryItem? = nil
  var isPresentAlert: Bool = false
  var isPresentSignInView: Bool = false
  var isPresentErrorAlert: Bool = false
}

enum RepositoryListAction: Equatable {
  case onAppear(RepositoryListViewType)
  
  case requestStarredItemList
  case requestStar(RequestStarState)
  case responseStar(Result<ResponseStarState, URLError>)
  
  case requestRepositoryItemList(String)
  case responseRepositoryItemList(Result<[RepositoryItem], URLError>)
  
  case routeSafariView(RepositoryItem?)
  case routeSignInView(RoutingState)
  case routeErrorAlert(RoutingState)
}

struct RepositoryListEnvironment {
  var userService: UserService
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
  case let .onAppear(viewType):
    if viewType == .searchList {
      return .init(value: .requestRepositoryItemList("swift"))
    } else {
      return .init(value: .requestStarredItemList)
    }
  case .requestStarredItemList:
    
    guard let ownerName = environment.userService.userInfo?.name else {
      return .init(value: .routeSignInView(.present))
    }
    
    return environment.starredUseCase.repositoryList(
      ownerName: ownerName
    )
    .receive(on: environment.mainQueue)
    .catchToEffect(RepositoryListAction.responseRepositoryItemList)
    
  case let .requestStar(requestState):
    if environment.userService.isSignIn {
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
      case let .unstar(id):
        state.repositoryItemList = repositoryItemList.filter {
          $0.id != id
        }
      }
      state.repositoryItemList = repositoryItemList
    case .failure:
      return .init(value: .routeErrorAlert(.present))
    }
    return .none
    
  case let .requestRepositoryItemList(query):
    return environment.searchUseCase.repositoryList(query: query)
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
    
  case let .routeSafariView(item):
    state.selectedItem = item
    return .none
    
  case let .routeSignInView(routingState):
    state.isPresentSignInView = (routingState == .present)
    return .none

  case let .routeErrorAlert(routingState):
    state.isPresentErrorAlert = (routingState == .present)
    return .none
  }
}

//protocol StarredRepository {
//  func requestRepositoryList(ownerName: String) -> AnyPublisher<[RepositoryItem], URLError>
//  func requestStarred(
//    ownerName: String,
//    repositoryName: String
//  ) -> AnyPublisher<EmptyResponse, URLError>
//  func requestUnStar(
//    ownerName: String,
//    repositoryName: String
//  ) -> AnyPublisher<EmptyResponse, URLError>
//}
//
//
//final class StarredDataRepository: StarredRepository {
//  
//  private let apiService: ApiService
//  
//  init(apiService: ApiService = ApiManager.shared) {
//    self.apiService = apiService
//  }
//}
//
//extension StarredDataRepository {
//  func requestRepositoryList(ownerName: String) -> AnyPublisher<[RepositoryItem], URLError> {
//    return apiService.request(
//      endPoint: .init(path: .starredList(ownerName))
//    ).map { (data: [RepositoryItem]) in
//      return data
//    }.eraseToAnyPublisher()
//  }
//  
//  func requestStarred(ownerName: String, repositoryName: String) -> AnyPublisher<EmptyResponse, URLError> {
//    return apiService.request(endPoint: .init(path: .starred(ownerName, repositoryName)))
//      .map { (data: EmptyResponse) in
//        return data
//      }.eraseToAnyPublisher()
//  }
//  
//  func requestUnStar(ownerName: String, repositoryName: String) -> AnyPublisher<EmptyResponse, URLError> {
//    return apiService.request(endPoint: .init(path: .unStar(ownerName, repositoryName)))
//      .map { (data: EmptyResponse) in
//        return data
//      }.eraseToAnyPublisher()
//  }
//}
//
//protocol StarredUseCase {
//  func repositoryList(ownerName: String) -> AnyPublisher<[RepositoryItem], URLError>
//  func starred(id: Int, ownerName: String, repositoryName: String) -> AnyPublisher<ResponseStarState, URLError>
//  func unStar(id: Int, ownerName: String, repositoryName: String) -> AnyPublisher<ResponseStarState, URLError>
//}
//
//enum ResponseStarState: Equatable {
//  case starred(Int), unstar(Int)
//}
//
//class StarredDefaultUseCase: StarredUseCase {
//  
//  let starredRepository: StarredRepository
//  
//  init(starredRepository: StarredRepository) {
//    self.starredRepository = starredRepository
//  }
//}
//
//extension StarredDefaultUseCase {
//  
//  private func makeRepositoryList(searchItemList: [RepositoryItem]) -> [RepositoryItem] {
//    var repositoryList: [RepositoryItem] = searchItemList
//    let _ = searchItemList.enumerated().map { offset, element in
//      repositoryList[offset].isStarred = true
//      repositoryList[offset].updatedDate = "Updated \(element.updatedDate.toDate?.toAgoString() ?? "")"
//    }
//    return repositoryList
//  }
//  
//  func repositoryList(ownerName: String) -> AnyPublisher<[RepositoryItem], URLError> {
//    return starredRepository.requestRepositoryList(
//      ownerName: ownerName
//    )
//    .compactMap { [weak self] searchItemList in
//      self?.makeRepositoryList(searchItemList: searchItemList)
//    }.eraseToAnyPublisher()
//  }
//  
//  func starred(id: Int, ownerName: String, repositoryName: String) -> AnyPublisher<ResponseStarState, URLError> {
//    return starredRepository.requestStarred(
//      ownerName: ownerName,
//      repositoryName: repositoryName
//    )
//    .flatMap { _ -> AnyPublisher<ResponseStarState, URLError> in
//      return Just<ResponseStarState>(.starred(id))
//        .setFailureType(to: URLError.self).eraseToAnyPublisher()
//    }.eraseToAnyPublisher()
//  }
//  
//  func unStar(id: Int, ownerName: String, repositoryName: String) -> AnyPublisher<ResponseStarState, URLError> {
//    return starredRepository.requestUnStar(
//      ownerName: ownerName,
//      repositoryName: repositoryName
//    )
//    .flatMap { _ -> AnyPublisher<ResponseStarState, URLError> in
//      return Just<ResponseStarState>(.unstar(id)).setFailureType(to: URLError.self).eraseToAnyPublisher()
//    }.eraseToAnyPublisher()
//  }
//}
