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
    infoPlist: InfoPlist? = nil,
    dependencies: [TargetDependency] = []
  ) -> Project {
    
    var targets: [Target] = []
    var schemes: [Scheme] = []
    
    let infoPlist: InfoPlist = infoPlist ?? .default(name: name)
    
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
    
    if let _ = products.first(where: { $0.isFramework }) {
        let target: Target = .init(
          name: name,
          platform: .iOS,
          product: products.first(where: {$0 == .framework}) != nil ? .framework : .staticFramework,
          bundleId: "com.butterfree.\(name)",
          deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
          infoPlist: infoPlist,
          sources: ["Sources/**"],
          resources: products.contains(.framework) ? ["Resources/**"] : nil,
          dependencies: dependencies,
          settings: settings
        )
        targets.append(target)
    }
    
    if let _ = products.first(where: { $0.isLibrary }) {
      let target: Target = .init(
        name: name,
        platform: .iOS,
        product: products.contains(.dynamicLibrary) ? .dynamicLibrary : .staticLibrary,
        bundleId: "com.butterfree.\(name)",
        deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
        infoPlist: infoPlist,
        sources: ["Sources/**"],
        resources: products.contains(.dynamicLibrary) ? ["Resources/**"] : nil,
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
        dependencies: [.target(name: name), .xctest]
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
      targets: targets,
      schemes: schemes
    )
  }
}

private extension Product {
  var isFramework: Bool {
    return (self == .staticFramework || self == .framework)
  }
  
  var isLibrary: Bool {
    return (self == .staticLibrary || self == .dynamicLibrary)
  }
}
