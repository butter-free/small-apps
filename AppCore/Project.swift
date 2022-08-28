//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sean on 2022/08/28.
//

import ProjectDescription
import ProjectDescriptionHelpers

let appCore = Project.feature(
  name: "AppCore",
  products: [.staticFramework],
  dependencies: [
    .external(name: "FirebaseAuth"),
    .external(name: "FirebaseAuthCombine-Community")
  ]
)
