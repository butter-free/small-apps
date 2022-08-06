//
//  TCAApp.swift
//  TCA
//
//  Created by sean on 2022/03/08.
//

import SwiftUI

import Firebase

@main
struct TCAApp: App {
  var body: some Scene {
    WindowGroup {
      MainView()
    }
  }
  
  init() {
    FirebaseApp.configure()
  }
}
