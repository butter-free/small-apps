//
//  ApiManagerStub.swift
//  TCA
//
//  Created by sean on 2022/05/04.
//

import Combine
import Foundation

class ApiManagerStub: ApiService {
  func requestItems<T>(endPoint: EndPoint) -> AnyPublisher<T, URLError> where T : Decodable {
    
    switch endPoint.path {
    case .search:
      let data: [SearchItem] = SampleData<[SearchItem]>(path: endPoint.path).create()
      return Just<T>(data as! T)
        .mapError { _ in URLError(URLError.Code.badServerResponse) }
        .eraseToAnyPublisher()
    }
  }
}
