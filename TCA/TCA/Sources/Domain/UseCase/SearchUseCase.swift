//
//  SearchUseCase.swift
//  TCA
//
//  Created by sean on 2022/04/24.
//

import Combine
import Foundation

protocol SearchUseCase {
  func repositoryList(query: String) -> AnyPublisher<[SearchItem], Never>
}
