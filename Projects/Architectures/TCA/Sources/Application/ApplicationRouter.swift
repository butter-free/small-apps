//
//  ApplicationRouter.swift
//  sample
//
//  Created by sean on 2023/07/01.
//

import SwiftUI

protocol Routable: ObservableObject {
  
  associatedtype Destination
  
  var navigationPath: NavigationPath { get }
  
  func navigate(to destination: Destination)
  func navigateBack()
  func navigateToRoot()
}

enum Destination: Hashable {
  case main
}

final class ApplicationRouter: Routable {
  
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
