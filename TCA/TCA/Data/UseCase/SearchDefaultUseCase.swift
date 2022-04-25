//
//  SearchDefaultUseCase.swift
//  TCA
//
//  Created by sean on 2022/04/24.
//

import Combine
import Foundation

class SearchDefaultUseCase: SearchUseCase {
  
  let repository: SearchRepository
  
  init(repository: SearchRepository) {
    self.repository = repository
  }
}

extension SearchDefaultUseCase {
  func repositoryList(query: String) -> AnyPublisher<[SearchItem], URLError> {
    return repository.requestRepositoryList(query: query)
      .map { searchItemList in
        var repositoryList: [SearchItem] = searchItemList
        let _ = searchItemList.enumerated().map { offset, element in
          repositoryList[offset].updatedDate = "Updated \(element.updatedDate.toDate?.toAgoString() ?? "")"
        }
        return repositoryList
      }.eraseToAnyPublisher()
  }
}
