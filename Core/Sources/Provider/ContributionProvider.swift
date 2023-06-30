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
    let urlString = "https://ghchart.rshah.org/\(userName)"
    
    guard let url = URL(string: urlString) else {
      return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
      .tryMap { (data, _) -> [Contribution] in
        do {
          guard let html = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
          }
          let document = try SwiftSoup.parse(html)
          return try document.select("rect")
            .compactMap { [unowned self] in self.parseContributions(from: $0) }
            .sorted(by: { lhs, rhs in
              return lhs.date <= rhs.date
            })
        } catch {
          throw URLError(.cannotParseResponse)
        }
      }
      .mapError { $0 as! URLError }
      .eraseToAnyPublisher()
  }
}

extension ContributionProvider {
  private func parseContributions(from element: Element) -> Contribution? {
    do {
      let dataScore = try element.attr("data-score")
      let dataDate = try element.attr("data-date")
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "YYYY-MM-dd"
      
      guard let score = Int(dataScore),
            let date = dateFormatter.date(from: dataDate) else {
        return nil
      }
      
      return Contribution(date: date, score: Contribution.Score(rawValue: score) ?? .empty)
    } catch let error {
      print(error)
    }
    
    return nil
  }
}
