//
//  NetworkError.swift
//  TCA
//
//  Created by sean on 2022/05/03.
//

import Foundation

enum NetworkError: Error, Equatable {
  case error(Error)
  case badResponse
}

extension NetworkError {
  static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    return lhs.localizedDescription == rhs.localizedDescription
  }
}
