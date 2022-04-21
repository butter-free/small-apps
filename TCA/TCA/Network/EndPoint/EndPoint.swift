//
//  EndPoint.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Foundation

enum PathType {
  case search(String)
}

struct EndPoint {
  private var baseURL: URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.github.com"
    return components.url!
  }
  
  let path: PathType
  
  init(path: PathType) {
    self.path = path
  }
}

extension EndPoint {
  
  var url: URL? {
    
    var components = URLComponents()
    components.scheme = baseURL.scheme
    components.host = baseURL.host
    
    var queryItems: [URLQueryItem] = []
    
    switch path {
    case let .search(query):
      components.path = "/search/repositories"
      queryItems = [
        .init(name: "q", value: query),
        .init(name: "sort", value: "stars"),
        .init(name: "order", value: "desc")
      ]
    }
    
    components.queryItems = queryItems
    
    return components.url
  }
}
