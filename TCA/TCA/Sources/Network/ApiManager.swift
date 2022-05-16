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
  
  func request<T>(endPoint: EndPoint) -> AnyPublisher<T, URLError> where T : Decodable {
    
    guard let url = endPoint.url else {
      return Empty<T, URLError>(completeImmediately: true).eraseToAnyPublisher()
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = endPoint.method.string
    
    if let header = endPoint.header {
      let _ = header.map {
        let key = $0.key
        let value = $0.value
        request.addValue(
          value,
          forHTTPHeaderField: key
        )
      }
    }
    
    return URLSession.shared.dataTaskPublisher(for: request)
      .tryMap { data, response -> (Data, Int) in
        guard let response = response as? HTTPURLResponse else {
          throw URLError(.unknown)
        }
        
        // 성공 상태코드가 204 등 200이 아닌 경우 대응
        guard 200 ..< 300 ~= response.statusCode else {
          throw URLError(.badServerResponse)
        }
        
        return (data, response.statusCode)
      }
      .flatMap { data, statusCode -> AnyPublisher<T, Error> in
        
        if data.isEmpty, statusCode == 204 {
          return Just(EmptyResponse() as! T).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        
        return Just(data).decode(type: T.self, decoder: JSONDecoder()).eraseToAnyPublisher()
      }
      .mapError { error -> URLError in
        if let error = error as? URLError {
          return error
        } else {
          return URLError(.cannotDecodeRawData)
        }
      }.eraseToAnyPublisher()
  }
}
