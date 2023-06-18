//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sean on 2022/08/28.
//

import ProjectDescription
import ProjectDescriptionHelpers

let appCore = Project.feature(
  name: "Core",
  products: [.framework],
  dependencies: [
    .ThirdParty.FireBase.Auth,
    .ThirdParty.FireBase.AuthCombine
  ]
)
