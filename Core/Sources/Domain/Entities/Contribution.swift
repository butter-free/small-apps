//
//  Contribution.swift
//  TCA
//
//  Created by sean on 2022/07/24.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

public struct Contribution: Equatable, Hashable {
  public enum Score: Int {
    case empty, one, two, three, more
  }
  
  public let date: Date
  public let score: Score
  
  public init(date: Date, score: Score) {
    self.date = date
    self.score = score
  }
}
