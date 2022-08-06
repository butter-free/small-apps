//
//  Project.swift
//  App
//
//  Created by sean on 2022/08/04.
//

import ProjectDescription
import ProjectDescriptionHelpers

let app = Project.featureFramework(
  name: "App",
  products: [.app],
  settings: Project.makeSettings(),
  dependencies: []
)
