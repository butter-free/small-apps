//
//  Project.swift
//  TCA
//
//  Created by sean on 2022/05/06.
//

import ProjectDescription
import ProjectDescriptionHelpers

let tca = Project.feature(
  name: "TCA",
  products: [.app, .unitTests],
  infoPlist: .custom(
    name: "TCA",
    extentions: [
      "CFBundleURLTypes": .array([
        .dictionary([
          "CFBundleTypeRole": .string("Editor"),
          "CFBundleURLSchemes": .array([
            .string("com.googleusercontent.apps.1035822977996-7r1up0avlf296ho78knjsqhbkf2s1994")
          ])
        ])
      ])
    ]
  ),
  dependencies: [
    .project(target: "AppCore", path: .relativeToRoot("AppCore")),
    .external(name: "ComposableArchitecture"),
    .external(name: "SwiftSoup")
  ]
)
