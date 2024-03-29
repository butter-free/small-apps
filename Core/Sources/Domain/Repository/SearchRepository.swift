//
//  SearchRepository.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Combine
import Foundation

public protocol SearchRepository {
  func requestRepositoryList(query: String) -> AnyPublisher<[RepositoryItem], URLError>
}
