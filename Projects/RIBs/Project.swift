//
//  Project.swift
//  RIBs
//
//  Created by sean on 2022/07/30.
//

import ProjectDescription
import ProjectDescriptionHelpers

let ribs = Project.feature(
  name: "RIBs",
  products: [.app, .unitTests],
  infoPlist: .custom(
    name: "RIBs",
    extentions: [
      "UIApplicationSceneManifest": .dictionary([
        "UIApplicationSupportsMultipleScenes": .boolean(false),
        "UISceneConfigurations": .dictionary([
          "UIWindowSceneSessionRoleApplication": .array([
            .dictionary([
              "UISceneConfigurationName": .string("Default Configuration"),
              "UISceneDelegateClassName": .string("$(PRODUCT_MODULE_NAME).SceneDelegate")
            ])
          ])
        ])
      ])
    ]
  ),
  dependencies: []
)
