//
//  Encodable+Extension.swift
//  TCA
//
//  Created by sean on 2022/05/17.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

extension Encodable {
  func asDictionary() -> [String: Any]? {
    do {
      let json = try JSONEncoder().encode(self)
      let dict = try JSONSerialization.jsonObject(
        with: json,
        options: .allowFragments
      ) as? [String: Any]
      return dict
    } catch let error {
      print(error)
      return nil
    }
  }
}
