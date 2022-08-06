//
//  UserManager.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

import FirebaseAuth

protocol UserService {
  var accessToken: String { get }
  var userInfo: UserInfo? { get }
  
  var isSignIn: Bool { get }
  
  func updateAccessToken(_ accessToken: String)
  func updateUserInfo(_ userInfo: UserInfo)
  func signOut()
}

class UserManager: UserService {
  
  static let shared: UserManager = UserManager()
  
  var accessToken: String {
    return UserDefaults.standard.string(forKey: .accessToken)
  }
  
  var userInfo: UserInfo? {
    return UserDefaults.standard.object(type: UserInfo.self, forKey: .userInfo)
  }
  
  var isSignIn: Bool {
    if let _ = Auth.auth().currentUser, let _ = userInfo {
      return true
    } else {
      return false
    }
  }
  
  private init() {}
  
  func updateAccessToken(_ accessToken: String) {
    UserDefaults.standard.set(accessToken, forKey: .accessToken)
  }
  
  func updateUserInfo(_ userInfo: UserInfo) {
    UserDefaults.standard.set(object: userInfo, forKey: .userInfo)
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
    } catch let error {
      print(error)
    }
    
    UserDefaults.standard.remove(forKey: .accessToken)
    UserDefaults.standard.remove(forKey: .userInfo)
  }
}
