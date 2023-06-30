//
//  ApplicationRouter.swift
//  sample
//
//  Created by sean on 2023/07/01.
//

import SwiftUI

final class ApplicationRouter: ObservableObject {
  
  enum Destination: Hashable {
    case main
  }
  
  @Published var navigationPath = NavigationPath()
  
  func navigate(to destination: Destination) {
    navigationPath.append(destination)
  }
  
  func navigateBack() {
    navigationPath.removeLast()
  }
  
  func navigateToRoot() {
    navigationPath.removeLast(navigationPath.count)
  }
}
