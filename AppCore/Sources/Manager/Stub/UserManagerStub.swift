//
//  UserManagerStub.swift
//  TCATests
//
//  Created by sean on 2022/05/18.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

final class UserManagerStub: UserService {
  
  var accessToken: String
  
  var userInfo: UserInfo?
  
  var isSignIn: Bool = false
  
  internal init(
    accessToken: String = "",
    userInfo: UserInfo? = nil,
    isSignIn: Bool = false
  ) {
    self.accessToken = accessToken
    self.userInfo = userInfo
    self.isSignIn = isSignIn
  }
  
  func updateAccessToken(_ accessToken: String) {
    self.accessToken = accessToken
  }
  
  func updateUserInfo(_ userInfo: UserInfo) {
    self.userInfo = userInfo
    self.isSignIn = true
  }
  
  func signOut() {
    self.accessToken = ""
    self.userInfo = nil
    self.isSignIn = false
  }
}
