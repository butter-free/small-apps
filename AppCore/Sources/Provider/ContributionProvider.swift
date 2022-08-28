//
//  ContributionProvider.swift
//  TCA
//
//  Created by sean on 2022/07/24.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Combine
import Foundation

import SwiftSoup

public final class ContributionProvider {
  
  let userName: String
  
  public init(userName: String) {
    self.userName = userName
  }
  
  public func contributions() -> AnyPublisher<[Contribution], URLError> {
    let urlString = "https://github.com/users/\(userName)/contributions"
    
    guard let url = URL(string: urlString) else {
      return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    
    do {
      let html = try String(contentsOf: url, encoding: .utf8)
      let document = try SwiftSoup.parse(html)
      let contributions = try document.select("rect")
        .compactMap { parseContributions(from: $0) }
        .filter { $0.date.isInSameYear(as: .now) }
        .sorted(by: { lhs, rhs in
          return lhs.date <= rhs.date
        })
      
      return Just(contributions)
        .setFailureType(to: URLError.self)
        .eraseToAnyPublisher()
    } catch {
      return Fail(error: URLError(.cannotParseResponse)).eraseToAnyPublisher()
    }
  }
}

extension ContributionProvider {
  private func parseContributions(from element: Element) -> Contribution? {
    do {
      let dataLevel = try element.attr("data-level")
      let dataCount = try element.attr("data-count")
      let dataDate = try element.attr("data-date")
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "YYYY-MM-dd"
      
      guard let level = Int(dataLevel),
            let count = Int(dataCount),
            let date = dateFormatter.date(from: dataDate) else {
        return nil
      }
      
      return Contribution(date: date, count: count, level: Contribution.Level(rawValue: level) ?? .less)
    } catch let error {
      print(error)
    }
    
    return nil
  }
}
