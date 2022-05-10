// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "0.34.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.15.0"),
    ]
)