//
//  SampleData.swift
//  TCA
//
//  Created by sean on 2022/05/04.
//

import Foundation

struct SampleData {
  
  let path: PathType
  
  func create() -> Data {
    switch path {
    case .userInfo:
      return makeData(
        parameter: [
          "id": -1,
          "login": "user",
          "avatar_url": "",
          "email": "",
          "bio": "",
          "followers": 0,
          "following": 0
        ]
      )
    case let .search(query):
      return makeData(
        parameter: [
          "items": [
            RepositoryItem(repositoryName: query).asDictionary()
          ]
        ]
      )
    case .starredList:
      return makeData(
        parameters: [
          RepositoryItem().asDictionary()!
        ]
      )
    default:
      return makeData(parameter: [:])
    }
  }
}

extension SampleData {
  func makeData(parameter: [String: Any]) -> Data {
    return try! JSONSerialization.data(withJSONObject: parameter)
  }
  
  func makeData(parameters: [[String: Any]]) -> Data {
    return try! JSONSerialization.data(withJSONObject: parameters)
  }
}
