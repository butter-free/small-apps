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
    case let .search(query):
      return toData(
        parameters: [
          "items": [
            RepositoryItem(repositoryName: query).asDictionary()
          ]
        ]
      )
    default:
      return toData(parameters: [:])
    }
  }
}

extension SampleData {
  func toData(parameters: [String: Any]) -> Data {
    return try! JSONSerialization.data(withJSONObject: parameters)
  }
}
