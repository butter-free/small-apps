//
//  Base.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Foundation

struct Base<T>: Decodable where T: Decodable {
  let items: T?
}

struct EmptyResponse: Decodable {}
