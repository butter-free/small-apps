//
//  ApiManagerStub.swift
//  TCA
//
//  Created by sean on 2022/05/04.
//

import Combine
import Foundation

final class ApiManagerStub: ApiService {
  
  let hasOccerError: Bool
  
  init(hasOccerError: Bool = false) {
    self.hasOccerError = hasOccerError
  }
  
  func request<T>(endPoint: EndPoint) -> AnyPublisher<T, URLError> where T : Decodable {
    
    if hasOccerError {
      return Fail(error: URLError(.cancelled)).eraseToAnyPublisher()
    }
    
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
  }
}
