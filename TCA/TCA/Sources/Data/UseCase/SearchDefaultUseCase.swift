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
  func repositoryList(query: String) -> AnyPublisher<[SearchItem], Never> {
    return repository.requestRepositoryList(query: query)
      .catch { error -> Just<[SearchItem]> in
        print(error)
        return Just<[SearchItem]>([])
      }
      .map { searchItemList in
        var repositoryList: [SearchItem] = searchItemList
        let _ = searchItemList.enumerated().map { offset, element in
          repositoryList[offset].updatedDate = "Updated \(element.updatedDate.toDate?.toAgoString() ?? "")"
        }
        return repositoryList
      }
      .eraseToAnyPublisher()
  }
}
