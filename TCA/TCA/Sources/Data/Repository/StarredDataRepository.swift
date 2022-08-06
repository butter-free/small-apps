//
//  StarredDataRepository.swift
//  TCA
//
//  Created by sean on 2022/05/11.
//  Copyright © 2022 sample. All rights reserved.
//

import Combine
import Foundation

final class StarredDataRepository: StarredRepository {
  
  private let apiService: ApiService
  
  init(apiService: ApiService = ApiManager.shared) {
    self.apiService = apiService
  }
}

extension StarredDataRepository {
  func requestRepositoryList(ownerName: String) -> AnyPublisher<[RepositoryItem], URLError> {
    return apiService.request(
      endPoint: .init(path: .starredList(ownerName))
    ).map { (data: [RepositoryItem]) in
      return data
    }.eraseToAnyPublisher()
  }
  
  func requestStarred(ownerName: String, repositoryName: String) -> AnyPublisher<EmptyResponse, URLError> {
    return apiService.request(endPoint: .init(path: .starred(ownerName, repositoryName)))
      .map { (data: EmptyResponse) in
        return data
      }.eraseToAnyPublisher()
  }
  
  func requestUnStar(ownerName: String, repositoryName: String) -> AnyPublisher<EmptyResponse, URLError> {
    return apiService.request(endPoint: .init(path: .unStar(ownerName, repositoryName)))
      .map { (data: EmptyResponse) in
        return data
      }.eraseToAnyPublisher()
  }
}
