//
//  ApiService.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Combine
import Foundation

public protocol ApiService {
  func request<T: Decodable>(endPoint: EndPoint) -> AnyPublisher<T, URLError>
}
