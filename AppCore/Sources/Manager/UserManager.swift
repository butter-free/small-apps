//
//  UserManager.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

import FirebaseAuth

public protocol UserService {
  var accessToken: String { get }
  var userInfo: UserInfo? { get }
  
  var isSignIn: Bool { get }
  
  func updateAccessToken(_ accessToken: String)
  func updateUserInfo(_ userInfo: UserInfo)
  func signOut()
}

public final class UserManager: UserService {
  
  public static let shared: UserManager = UserManager()
  
  public var accessToken: String {
    return UserDefaults.standard.string(forKey: .accessToken)
  }
  
  public var userInfo: UserInfo? {
    return UserDefaults.standard.object(type: UserInfo.self, forKey: .userInfo)
  }
  
  public var isSignIn: Bool {
    if let _ = Auth.auth().currentUser, let _ = userInfo {
      return true
    } else {
      return false
    }
  }
  
  private init() {}
  
  public func updateAccessToken(_ accessToken: String) {
    UserDefaults.standard.set(accessToken, forKey: .accessToken)
  }
  
  public func updateUserInfo(_ userInfo: UserInfo) {
    UserDefaults.standard.set(object: userInfo, forKey: .userInfo)
  }
  
  public func signOut() {
    do {
      try Auth.auth().signOut()
    } catch let error {
      print(error)
    }
    
    UserDefaults.standard.remove(forKey: .accessToken)
    UserDefaults.standard.remove(forKey: .userInfo)
  }
}
