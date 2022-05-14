//
//  StarredDefaultUseCase.swift
//  TCA
//
//  Created by sean on 2022/05/12.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Combine
import Foundation

enum ResponseStarState: Equatable {
  case starred(Int), unstar(Int)
}

class StarredDefaultUseCase: StarredUseCase {
  
  let starredRepository: StarredRepository
  
  init(starredRepository: StarredRepository) {
    self.starredRepository = starredRepository
  }
}

extension StarredDefaultUseCase {
  
  private func makeRepositoryList(searchItemList: [RepositoryItem]) -> [RepositoryItem] {
    var repositoryList: [RepositoryItem] = searchItemList
    let _ = searchItemList.enumerated().map { offset, element in
      repositoryList[offset].isStarred = true
      repositoryList[offset].updatedDate = "Updated \(element.updatedDate.toDate?.toAgoString() ?? "")"
    }
    return repositoryList
  }
  
  func repositoryList(ownerName: String) -> AnyPublisher<[RepositoryItem], URLError> {
    return starredRepository.requestRepositoryList(
      ownerName: ownerName
    )
    .compactMap { [weak self] searchItemList in
      self?.makeRepositoryList(searchItemList: searchItemList)
    }.eraseToAnyPublisher()
  }
  
  func starred(id: Int, ownerName: String, repositoryName: String) -> AnyPublisher<ResponseStarState, URLError> {
    return starredRepository.requestStarred(
      ownerName: ownerName,
      repositoryName: repositoryName
    )
    .flatMap { _ -> AnyPublisher<ResponseStarState, URLError> in
      return Just<ResponseStarState>(.starred(id))
        .setFailureType(to: URLError.self).eraseToAnyPublisher()
    }.eraseToAnyPublisher()
  }
  
  func unStar(id: Int, ownerName: String, repositoryName: String) -> AnyPublisher<ResponseStarState, URLError> {
    return starredRepository.requestUnStar(
      ownerName: ownerName,
      repositoryName: repositoryName
    )
    .flatMap { _ -> AnyPublisher<ResponseStarState, URLError> in
      return Just<ResponseStarState>(.unstar(id)).setFailureType(to: URLError.self).eraseToAnyPublisher()
    }.eraseToAnyPublisher()
  }
}
