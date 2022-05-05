//
//  SampleData.swift
//  TCA
//
//  Created by sean on 2022/05/04.
//

import Foundation

struct SampleData<T: Decodable> {
  
  let path: PathType
  
  func create() -> T {
    switch path {
    case .search:
      return [
        SearchItem(updatedDate: "2022-05-04T17:32:00Z")
      ] as! T
    }
  }
}
