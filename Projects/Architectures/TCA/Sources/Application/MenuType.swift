//
//  MenuType.swift
//  sample
//
//  Created by sean on 2023/07/02.
//

import Foundation

enum MenuType: String, Identifiable, CaseIterable {
  case search, starred, profile, setting
  
  var id: MenuType { self }
  
  var imageName: String {
    switch self {
    case .search:
      return "flame.fill"
    case .starred:
      return "star"
    case .profile:
      return "person"
    default:
      return "gearshape"
    }
  }
}
