//
//  Contribution.swift
//  TCA
//
//  Created by sean on 2022/07/24.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

struct Contribution: Equatable, Hashable {
  enum Level: Int {
    case less, one, two, three, more
  }
  
  let date: Date
  let count: Int
  let level: Level
  
  init(date: Date, count: Int, level: Level) {
    self.date = date
    self.count = count
    self.level = level
  }
}
