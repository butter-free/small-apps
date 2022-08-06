//
//  Project+Templates.swift
//  small-appsManifests
//
//  Created by sean on 2022/07/31.
//

import ProjectDescription

extension Project {
  public static func featureFramework(
    name: String,
    products: [Product],
    settings: Settings? = nil,
    infoPlist: InfoPlist = .default,
    dependencies: [TargetDependency] = []
  ) -> Project {
    
    var targets: [Target] = []
    
    if products.contains(.app) {
      let target: Target = .init(
        name: name,
        platform: .iOS,
        product: .app,
        bundleId: "com.butterfree.\(name)",
        deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
        infoPlist: infoPlist,
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        dependencies: dependencies,
        settings: settings
      )
      targets.append(target)
    }
    
    if products.contains(.unitTests) {
      let target: Target = .init(
        name: "\(name)Tests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "com.butterfree.\(name)Tests",
        infoPlist: .default,
        sources: ["\(name)Tests/**"],
        resources: ["\(name)Tests/**"],
        dependencies: [.target(name: name)]
      )
      targets.append(target)
    }
    
    if products.contains(.uiTests) {
      let target: Target = .init(
        name: "\(name)UITests",
        platform: .iOS,
        product: .uiTests,
        bundleId: "com.butterfree.\(name)UITests",
        sources: "\(name)UITests/**",
        dependencies: [.target(name: name)]
      )
      targets.append(target)
    }
    
    return Project(
      name: name,
      targets: targets
    )
  }
  
  public static func makeSettings() -> Settings {
    
    let baseSetting: [String: SettingValue] = [:]
    
    return .settings(
      base: baseSetting,
      configurations: [
        .release(name: .release)
      ],
      defaultSettings: .recommended
    )
  }
  
  // info.plist의 내용을 직접 지정
  public static func makeInfoPlist(
    name: String,
    bundleName: String = "com.butterfree"
  ) -> [String: InfoPlist.Value] {
    return [
      "CFBundleName": .string(name),
      "CFBundleDisplayName": .string(name),
      "CFBundleIdentifier": .string("\(bundleName).sample"),
      "CFBundleShortVersionString": .string("1.0"),
      "CFBundleVersion": .string("0"),
      "CFBuildVersion": .string("0"),
      "CFBundleURLTypes": .array([
        .dictionary([
          "CFBundleTypeRole": .string("Editor"),
          "CFBundleURLSchemes": .array([
            .string("com.googleusercontent.apps.1035822977996-7r1up0avlf296ho78knjsqhbkf2s1994")
          ])
        ])
      ]),
      "UILaunchStoryboardName": .string("Launch Screen"),
      "UISupportedInterfaceOrientations": .array([.string("UIInterfaceOrientationPortrait")]),
      "UIUserInterfaceStyle": .string("Light")
    ]
  }
}
