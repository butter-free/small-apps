//
//  ApiManagerStub.swift
//  TCA
//
//  Created by sean on 2022/05/04.
//

import Combine
import Foundation

class ApiManagerStub: ApiService {
  func request<T>(endPoint: EndPoint) -> AnyPublisher<T, URLError> where T : Decodable {
    
    switch endPoint.path {
    case .search:
      let data = SampleData(
        path: endPoint.path
      ).create()
      return Just(data)
        .decode(type: T.self, decoder: JSONDecoder()).eraseToAnyPublisher()
        .mapError { error -> URLError in
          if let error = error as? URLError {
            return error
          } else {
            return URLError(.cannotDecodeRawData)
          }
        }.eraseToAnyPublisher()
    default:
      return Empty(completeImmediately: true).eraseToAnyPublisher()
    }
  }
}
