//
//  SearchDataRepository.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Combine
import Foundation

final class SearchDataRepository: SearchRepository {

  private let apiService: ApiService
  
  init(apiService: ApiService = ApiManager.shared) {
    self.apiService = apiService
  }
}

extension SearchDataRepository {
  func requestRepositoryList(query: String) -> AnyPublisher<[SearchItem], URLError> {
    return apiService.requestItems(
      endPoint: .init(path: .search(query))
    )
    .map { (data: [SearchItem]) in
      return data
    }.eraseToAnyPublisher()
  }
}
