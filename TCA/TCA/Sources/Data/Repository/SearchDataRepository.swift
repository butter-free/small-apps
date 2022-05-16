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
  func requestRepositoryList(query: String) -> AnyPublisher<[RepositoryItem], URLError> {
    return apiService.request(
      endPoint: .init(path: .search(query))
    )
    .compactMap { (data: Base<[RepositoryItem]>) in
      return data.items
    }.eraseToAnyPublisher()
  }
}
