//
//  SearchDefaultUseCase.swift
//  TCA
//
//  Created by sean on 2022/04/24.
//

import Combine
import Foundation

public final class SearchDefaultUseCase: SearchUseCase {
  
  let searchRepository: SearchRepository
  
  public init(searchRepository: SearchRepository) {
    self.searchRepository = searchRepository
  }
}

extension SearchDefaultUseCase {
  
  private func makeRepositoryList(searchItemList: [RepositoryItem]) -> [RepositoryItem] {
    var repositoryList: [RepositoryItem] = searchItemList
    let _ = searchItemList.enumerated().map { offset, element in
      repositoryList[offset].isStarred = false
      if let updatedDate = element.updatedDate.toDate?.toAgoString() {
        repositoryList[offset].updatedDate = "Updated \(updatedDate)"
      }
    }
    return repositoryList
  }
  
  public func repositoryList(query: String) -> AnyPublisher<[RepositoryItem], URLError> {
    return searchRepository.requestRepositoryList(query: query)
      .compactMap { [weak self] searchItemList in
        self?.makeRepositoryList(searchItemList: searchItemList)
      }
      .eraseToAnyPublisher()
  }
}
