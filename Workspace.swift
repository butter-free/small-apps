//
//  Workspace.swift
//  TCAManifests
//
//  Created by sean on 2022/07/29.
//

import ProjectDescription

let workspace = Workspace(
  name: "Sample",
  projects: [
    "Core",
    "Projects/**"
  ]
)
