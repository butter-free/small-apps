//
//  Project+Templates.swift
//  small-appsManifests
//
//  Created by sean on 2022/07/31.
//

import ProjectDescription

extension Project {
  public static func feature(
    name: String,
    products: [Product],
    settings: Settings? = .default,
    infoPlist: InfoPlist = .default,
    dependencies: [TargetDependency] = []
  ) -> Project {
    
    var targets: [Target] = []

    let target: Target = .init(
      name: name,
      platform: .iOS,
      product: products[0],
      bundleId: "com.butterfree.\(name)",
      deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
      infoPlist: infoPlist,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: dependencies,
      settings: settings
    )
    targets.append(target)
    
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
}
