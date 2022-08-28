//
//  StarredUseCase.swift
//  TCA
//
//  Created by sean on 2022/05/12.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Combine
import Foundation

public protocol StarredUseCase {
  func repositoryList(ownerName: String) -> AnyPublisher<[RepositoryItem], URLError>
  func starred(id: Int, ownerName: String, repositoryName: String) -> AnyPublisher<ResponseStarState, URLError>
  func unStar(id: Int, ownerName: String, repositoryName: String) -> AnyPublisher<ResponseStarState, URLError>
}
