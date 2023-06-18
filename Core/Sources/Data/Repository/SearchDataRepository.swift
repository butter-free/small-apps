//
//  SearchDataRepository.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Combine
import Foundation

public final class SearchDataRepository: SearchRepository {

  private let apiService: ApiService
  
  public init(apiService: ApiService = ApiManager.shared) {
    self.apiService = apiService
  }
}

extension SearchDataRepository {
  public func requestRepositoryList(query: String) -> AnyPublisher<[RepositoryItem], URLError> {
    return apiService.request(
      endPoint: .init(path: .search(query))
    )
    .compactMap { (data: Base<[RepositoryItem]>) in
      return data.items
    }.eraseToAnyPublisher()
  }
}
