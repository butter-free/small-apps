//
//  Date+Extension.swift
//  TCA
//
//  Created by sean on 2022/04/24.
//

import Foundation

// https://www.hackingwithswift.com/forums/swiftui/swiftui-how-to-check-if-date-is-in-the-same-year/11834
extension Date {
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
}

extension Date {
  func toAgoString(locale: Locale = .init(identifier: "en_US")) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    formatter.dateTimeStyle = .named
    formatter.locale = locale
    return formatter.localizedString(for: self, relativeTo: Date())
  }
}
