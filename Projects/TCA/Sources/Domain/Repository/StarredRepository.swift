//
//  StarredRepository.swift
//  TCA
//
//  Created by sean on 2022/05/11.
//  Copyright © 2022 sample. All rights reserved.
//

import Combine
import Foundation

protocol StarredRepository {
  func requestRepositoryList(ownerName: String) -> AnyPublisher<[RepositoryItem], URLError>
  func requestStarred(
    ownerName: String,
    repositoryName: String
  ) -> AnyPublisher<EmptyResponse, URLError>
  func requestUnStar(
    ownerName: String,
    repositoryName: String
  ) -> AnyPublisher<EmptyResponse, URLError>
}
