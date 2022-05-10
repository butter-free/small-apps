//
//  ApiManager.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Combine
import Foundation

final class ApiManager: ApiService {
  
  static let shared: ApiManager = ApiManager()
  
  private init() {}
  
  func requestItems<T: Decodable>(endPoint: EndPoint) -> AnyPublisher<T, URLError> {
    
    guard let url = endPoint.url else {
      return Empty<T, URLError>(completeImmediately: true).eraseToAnyPublisher()
    }
    
    let request = URLRequest(url: url)
    
    return URLSession.shared.dataTaskPublisher(for: request)
      .tryMap { data, response in
        guard let response = response as? HTTPURLResponse else {
          throw URLError(.unknown)
        }
        
        guard 200 == response.statusCode else {
          throw URLError(.badServerResponse)
        }
        
        return data
      }
      .decode(type: Base<T>.self, decoder: JSONDecoder())
      .mapError { error in
        if let error = error as? URLError {
          return error
        } else {
          return URLError(.unknown)
        }
      }
      .compactMap { $0.items }
      .eraseToAnyPublisher()
  }
}
