//
//  String+Extension.swift
//  TCA
//
//  Created by sean on 2022/04/24.
//

import Foundation

extension String {
  var toDate: Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return formatter.date(from: self)
  }
}
