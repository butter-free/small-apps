//
//  Project.swift
//  TCA
//
//  Created by sean on 2022/05/06.
//

import ProjectDescription
import ProjectDescriptionHelpers

let tca = Project.featureFramework(
  name: "TCA",
  products: [.app, .unitTests],
  settings: Project.makeSettings(),
  infoPlist: .extendingDefault(with: Project.makeInfoPlist(name: "TCA")),
  dependencies: [
    .external(name: "ComposableArchitecture"),
    .external(name: "FirebaseAuth"),
    .external(name: "FirebaseAuthCombine-Community"),
    .external(name: "SwiftSoup")
  ]
)
