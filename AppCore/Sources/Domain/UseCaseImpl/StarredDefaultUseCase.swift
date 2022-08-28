//
//  StarredDefaultUseCase.swift
//  TCA
//
//  Created by sean on 2022/05/12.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Combine
import Foundation

public enum ResponseStarState: Equatable {
  case starred(Int), unstar(Int)
}

public final class StarredDefaultUseCase: StarredUseCase {
  
  let starredRepository: StarredRepository
  
  public init(starredRepository: StarredRepository) {
    self.starredRepository = starredRepository
  }
}

extension StarredDefaultUseCase {
  
  private func makeRepositoryList(searchItemList: [RepositoryItem]) -> [RepositoryItem] {
    var repositoryList: [RepositoryItem] = searchItemList
    let _ = searchItemList.enumerated().map { offset, element in
      repositoryList[offset].isStarred = true
      
      if let agoString = element.updatedDate.toDate?.toAgoString() {
        repositoryList[offset].updatedDate = "Updated \(agoString)"
      }
    }
    return repositoryList
  }
  
  public func repositoryList(ownerName: String) -> AnyPublisher<[RepositoryItem], URLError> {
    return starredRepository.requestRepositoryList(
      ownerName: ownerName
    )
    .compactMap { [weak self] searchItemList in
      self?.makeRepositoryList(searchItemList: searchItemList)
    }.eraseToAnyPublisher()
  }
  
  public func starred(id: Int, ownerName: String, repositoryName: String) -> AnyPublisher<ResponseStarState, URLError> {
    return starredRepository.requestStarred(
      ownerName: ownerName,
      repositoryName: repositoryName
    )
    .flatMap { _ -> AnyPublisher<ResponseStarState, URLError> in
      return Just<ResponseStarState>(.starred(id))
        .setFailureType(to: URLError.self).eraseToAnyPublisher()
    }.eraseToAnyPublisher()
  }
  
  public func unStar(id: Int, ownerName: String, repositoryName: String) -> AnyPublisher<ResponseStarState, URLError> {
    return starredRepository.requestUnStar(
      ownerName: ownerName,
      repositoryName: repositoryName
    )
    .flatMap { _ -> AnyPublisher<ResponseStarState, URLError> in
      return Just<ResponseStarState>(.unstar(id)).setFailureType(to: URLError.self).eraseToAnyPublisher()
    }.eraseToAnyPublisher()
  }
}
