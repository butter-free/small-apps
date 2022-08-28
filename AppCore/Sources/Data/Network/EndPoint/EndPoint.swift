//
//  EndPoint.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Foundation

enum PathType {
  case search(String)
  case starredList(String)
  case starred(String, String)
  case unStar(String, String)
  case userInfo(String)
}

enum HTTPMethod {
  case get, post, put, delete
  
  var string: String {
    switch self {
    case .get:
      return "GET"
    case .post:
      return "POST"
    case .put:
      return "PUT"
    case .delete:
      return "DELETE"
    }
  }
}

public struct EndPoint {
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
  
  var header: [String: String]? {
    return ["Authorization": UserManager.shared.accessToken]
  }
  
  var url: URL? {
    
    var components = URLComponents()
    components.scheme = baseURL.scheme
    components.host = baseURL.host
    
    var queryItems: [URLQueryItem] = []
    
    switch path {
    case .userInfo:
      components.path = "/user"
    case let .search(query):
      components.path = "/search/repositories"
      queryItems = [
        .init(name: "q", value: query),
        .init(name: "sort", value: "stars"),
        .init(name: "order", value: "desc")
      ]
    case let .starredList(userName):
      components.path = "/users/\(userName)/starred"
    case let .starred(ownerName, repositoryName), let .unStar(ownerName, repositoryName):
      components.path = "/user/starred/\(ownerName)/\(repositoryName)"
    }
    
    components.queryItems = queryItems
    
    return components.url
  }
  
  var method: HTTPMethod {
    switch path {
    case .starred:
      return .put
    case .unStar:
      return .delete
    default:
      return .get
    }
  }
}
