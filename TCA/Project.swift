//
//  Project.swift
//  TCA
//
//  Created by sean on 2022/05/06.
//

import ProjectDescription

let projectName: String = "TCA"
let organizationName: String = "butterfree"
let bundleName: String = "com.butterfree"

let baseSetting: [String: SettingValue] = [
  "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
  "OTHER_LDFLAGS": "$(inherited) -Xlinker -interposable"
]

// info.plist의 내용을 직접 지정
// TODO: - Build version auto increment & template
let infoPlist: [String: InfoPlist.Value] = [
  "CFBundleName": "\(projectName)",
  "CFBundleDisplayName": "\(projectName)",
  "CFBundleIdentifier": "\(bundleName).sample",
  "CFBundleShortVersionString": "1.0",
  "CFBundleVersion": "0",
  "CFBuildVersion": "0",
  "CFBundleURLTypes": [[
    "CFBundleTypeRole": "Editor",
    "CFBundleURLSchemes": ["com.googleusercontent.apps.1035822977996-7r1up0avlf296ho78knjsqhbkf2s1994"]
  ]],
  "UILaunchStoryboardName": "Launch Screen",
  "UISupportedInterfaceOrientations" : ["UIInterfaceOrientationPortrait"],
  "UIUserInterfaceStyle":"Light"
]

let settings: Settings = .settings(
  base: baseSetting,
  configurations: [
    .release(name: .release)
  ],
  defaultSettings: .recommended
)

let targets = [
  Target(
    name: projectName,
    platform: .iOS,
    product: .app,
    bundleId: "\(bundleName).sample",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    infoPlist: .extendingDefault(with: infoPlist),
    sources: "\(projectName)/Sources/**",
    resources: "\(projectName)/Resources/**",
    dependencies: [
      .external(name: "ComposableArchitecture"),
      .external(name: "FirebaseAuth"),
      .external(name: "FirebaseAuthCombine-Community")
    ],
    settings: settings
  ),
  Target( /// unit test
    name: "\(projectName)Tests",
    platform: .iOS,
    product: .unitTests,
    bundleId: "\(bundleName).\(projectName)Tests",
    sources: "\(projectName)Tests/**",
    dependencies: [
      .target(name: projectName) /// 테스트의 의존성은 실제 프로젝트에 있음
    ]
        ),
  Target(
    name: "\(projectName)UITests",
    platform: .iOS,
    product: .uiTests,
    bundleId: "\(bundleName).\(projectName)UITests",
    sources: "\(projectName)UITests/**",
    dependencies: [
      .target(name: projectName)
    ]
  )
]

let project = Project(
  name: projectName,
  organizationName: organizationName,
  targets: targets
)
