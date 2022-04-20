//
//  UIApplication+Extension.swift
//  TCA
//
//  Created by sean on 2022/04/19.
//

import UIKit

extension UIApplication {
  static func keyWindow() -> UIWindow? {
    let keyWindow = UIApplication
    .shared
    .connectedScenes
    .compactMap { $0 as? UIWindowScene }
    .flatMap { $0.windows }
    .first

    return keyWindow
  }
}
