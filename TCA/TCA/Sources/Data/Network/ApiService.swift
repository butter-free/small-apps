//
//  ApiService.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Combine
import Foundation

protocol ApiService {
  func request<T: Decodable>(endPoint: EndPoint) -> AnyPublisher<T, URLError>
}
