//
//  Project.swift
//  RIBs
//
//  Created by sean on 2022/07/30.
//

import ProjectDescription
import ProjectDescriptionHelpers

let ribs = Project.featureFramework(
  name: "RIBs",
  products: [.app, .unitTests],
  settings: Project.makeSettings(),
  dependencies: []
)
