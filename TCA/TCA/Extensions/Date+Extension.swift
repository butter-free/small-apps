//
//  Date+Extension.swift
//  TCA
//
//  Created by sean on 2022/04/24.
//

import Foundation

extension Date {
  func toAgoString(locale: Locale = .init(identifier: "en_US")) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    formatter.dateTimeStyle = .named
    formatter.locale = locale
    return formatter.localizedString(for: self, relativeTo: Date())
  }
}
