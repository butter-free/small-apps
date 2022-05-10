//
//  Dependencies.swift
//  TCAManifests
//
//  Created by sean on 2022/05/10.
//

import ProjectDescription

let dependencies = Dependencies(
  swiftPackageManager: [
    .remote(
      url: "https://github.com/pointfreeco/swift-composable-architecture.git",
      requirement: .upToNextMajor(from: "0.34.0")
    ),
    .remote(
      url: "https://github.com/firebase/firebase-ios-sdk.git",
      requirement: .upToNextMajor(from: "8.15.0")
    )
  ],
  platforms: [.iOS]
)
