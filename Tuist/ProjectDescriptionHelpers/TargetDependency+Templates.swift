//
//  TargetDependency+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by sean on 2023/06/17.
//

import ProjectDescription

extension TargetDependency {
  public struct Projects {
    public struct Architectures {}
  }
  
  public struct ThirdParty {
    public struct FireBase {}
  }
}

extension TargetDependency.Projects {
  public static let Core: TargetDependency = .project(
    target: "Core",
    path: .relativeToRoot("Core")
  )
}

extension TargetDependency.Projects.Architectures {
  public static let TCA: TargetDependency = .project(
    target: "TCA",
    path: .relativeToRoot("Projects/Architectures/TCA")
  )
}

extension TargetDependency.ThirdParty {
  public static let TCA: TargetDependency = .external(name: "ComposableArchitecture")
  public static let SwiftSoup: TargetDependency = .external(name: "SwiftSoup")
}

extension TargetDependency.ThirdParty.FireBase {
  public static let Auth: TargetDependency = .external(name: "FirebaseAuth")
  public static let AuthCombine: TargetDependency = .external(name: "FirebaseAuthCombine-Community")
}
