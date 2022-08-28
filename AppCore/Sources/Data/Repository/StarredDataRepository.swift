//
//  StarredDataRepository.swift
//  TCA
//
//  Created by sean on 2022/05/11.
//  Copyright © 2022 sample. All rights reserved.
//

import Combine
import Foundation

public final class StarredDataRepository: StarredRepository {
  
  private let apiService: ApiService
  
  public init(apiService: ApiService = ApiManager.shared) {
    self.apiService = apiService
  }
}

extension StarredDataRepository {
  public func requestRepositoryList(ownerName: String) -> AnyPublisher<[RepositoryItem], URLError> {
    return apiService.request(
      endPoint: .init(path: .starredList(ownerName))
    ).map { (data: [RepositoryItem]) in
      return data
    }.eraseToAnyPublisher()
  }
  
  public func requestStarred(ownerName: String, repositoryName: String) -> AnyPublisher<EmptyResponse, URLError> {
    return apiService.request(endPoint: .init(path: .starred(ownerName, repositoryName)))
      .map { (data: EmptyResponse) in
        return data
      }.eraseToAnyPublisher()
  }
  
  public func requestUnStar(ownerName: String, repositoryName: String) -> AnyPublisher<EmptyResponse, URLError> {
    return apiService.request(endPoint: .init(path: .unStar(ownerName, repositoryName)))
      .map { (data: EmptyResponse) in
        return data
      }.eraseToAnyPublisher()
  }
}
