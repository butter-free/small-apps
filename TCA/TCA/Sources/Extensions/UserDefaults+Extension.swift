//
//  UserDefaults+Extension.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
  case accessToken
  case userInfo
}

extension UserDefaults {
  func isExists(forKey: UserDefaultsKeys) -> Bool {
    return object(forKey: forKey) != nil
  }

  func set(_ value: Any?, forKey: UserDefaultsKeys) {
    set(value, forKey: forKey.rawValue)
  }

  func set<T: Encodable>(object: T, forKey: UserDefaultsKeys) {
    if let data = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false) {
      set(data, forKey: forKey.rawValue)
    } else {
      print("Failed Save Object")
    }
  }

  func string(forKey: UserDefaultsKeys) -> String {
    return string(forKey: forKey.rawValue) ?? ""
  }

  func array(forKey: UserDefaultsKeys) -> [Any] {
    return array(forKey: forKey.rawValue) ?? []
  }

  func dictionary(forKey: UserDefaultsKeys) -> [String: Any]? {
    return dictionary(forKey: forKey.rawValue)
  }

  func data(forKey: UserDefaultsKeys) -> Data? {
    return data(forKey: forKey.rawValue)
  }

  func stringArray(forKey: UserDefaultsKeys) -> [String]? {
    return stringArray(forKey: forKey.rawValue)
  }

  func integer(forKey: UserDefaultsKeys) -> Int {
    return integer(forKey: forKey.rawValue)
  }

  func float(forKey: UserDefaultsKeys) -> Float {
    return float(forKey: forKey.rawValue)
  }

  func double(forKey: UserDefaultsKeys) -> Double {
    return double(forKey: forKey.rawValue)
  }

  func bool(forKey: UserDefaultsKeys) -> Bool {
    return bool(forKey: forKey.rawValue)
  }

  func object(forKey: UserDefaultsKeys) -> Any? {
    return object(forKey: forKey.rawValue)
  }

  func object<T: Decodable>(type: T.Type, forKey: UserDefaultsKeys) -> T? {

    if let data = data(forKey: forKey.rawValue) {
      if let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T {
        return object
      } else {
        print("fail decode object")
        return nil
      }
    } else {
      print("fail find key")
      return nil
    }
  }

  func remove(forKey: UserDefaultsKeys) {
    return removeObject(forKey: forKey.rawValue)
  }
}
