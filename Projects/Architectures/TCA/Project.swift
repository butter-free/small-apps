//
//  Project.swift
//  TCA
//
//  Created by sean on 2022/05/06.
//

import ProjectDescription
import ProjectDescriptionHelpers

let tca = Project.feature(
  name: "sample",
  products: [.app],
  infoPlist: .custom(
    name: "sample",
    extentions: [
      "CFBundleURLTypes": .array([
        .dictionary([
          "CFBundleTypeRole": .string("Editor"),
          "CFBundleURLSchemes": .array([
            .string("app-1-1035822977996-ios-86eaeaa4946e89735a4369")
          ])
        ])
      ])
    ]
  ),
  dependencies: [
    .Projects.Core,
    .ThirdParty.TCA,
    .ThirdParty.SwiftSoup
  ]
)
