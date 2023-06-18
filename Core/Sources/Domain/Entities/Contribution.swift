//
//  Contribution.swift
//  TCA
//
//  Created by sean on 2022/07/24.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

public struct Contribution: Equatable, Hashable {
  public enum Level: Int {
    case less, one, two, three, more
  }
  
  public let date: Date
  public let count: Int
  public let level: Level
  
  public init(date: Date, count: Int, level: Level) {
    self.date = date
    self.count = count
    self.level = level
  }
}
