//
//  UIDevice+Extension.swift
//  TCA
//
//  Created by sean on 2022/04/19.
//

import UIKit

extension UIDevice {
  /// Notch 화면 판단을 위해 사용.
  var hasNotch: Bool {
    return UIApplication.keyWindow()?.safeAreaInsets.bottom ?? 0 > 0
  }
}
