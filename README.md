# :game_die: small-apps

> iOS 학습 내용이해를 위한 실습예제 및 내용정리 저장소


## 예제 프로젝트 구성

> 깃허브 Trending과 검색 및 Star관리 프로젝트를 구성하여 실습 예제로 사용

## Figma

![stroybard](./Resources/storyboard.png)


> https://www.figma.com/file/inFmSmLVg0xtIlPZ1GCm0h/Github-Trending-App?node-id=0%3A1

## Tuist

> 프로젝트 파일 및 폴더 변경시 .xcodeproj가 수시로 변경되어 협업시 빈번한 깃 충돌을 발생시킨다.
> Tuist를 이용하여 **로컬 폴더구조를 기반으로 프로젝트를 생성**하여 .xcodeproj의 지옥에서 벗어나보자!
> https://docs.tuist.io/tutorial/get-started

#### Project.swift
> 프로젝트 생성을 위한 정보가 담긴 파일

```swift
import ProjectDescription

// 공용 사용을 위해 변수 지정.
let projectName: String = "TCA"
let organizationName: String = "sample"
let bundleName: String = "com.sample"

// 기본 설정 (MARKETING_VERSION, PRODUCT_MODULE_NAME 등 사용시 설정.)
let baseSetting: [String: SettingValue] = [:]

// info.plist의 내용을 직접 지정
let infoPlist: [String: InfoPlist.Value] = [
  "CFBundleName": "\(projectName)",
  "CFBundleDisplayName": "\(projectName)",
  "CFBundleIdentifier": "\(bundleName).\(projectName)",
  "CFBundleShortVersionString": "1.0",
  "CFBundleVersion": "0",
  "CFBuildVersion": "0",
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
    bundleId: "\(bundleName).\(projectName)",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    infoPlist: .extendingDefault(with: infoPlist), // 작성된 plist 지정
    sources: "\(projectName)/Sources/**",     // tuist generate 이전에 동일한 폴더구조를 생성해야 한다.
    resources: "\(projectName)/Resources/**", // 마찬가지..
    dependencies: [
      .external(name: "ComposableArchitecture"), // Dependencies.swift에 정의한 라이브러리의 이름
      .external(name: "FirebaseAuth"),
      .external(name: "FirebaseAuthCombine-Community")
    ],
    settings: settings
  ),
  Target(
    name: "\(projectName)Tests",
    platform: .iOS,
    product: .unitTests,
    bundleId: "\(bundleName).\(projectName)Tests",
    sources: "\(projectName)Tests/**",
    dependencies: [
      .target(name: projectName)
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
```

#### Dependencies.swift
> 외부 라이브러리 의존성을 위해 별도 파일로 생성해서 사용해야 한다.
> Tuist 폴더내에 Dependencies.swift 이름으로 지정해야 한다.

```swift
import ProjectDescription

let dependencies = Dependencies(
  swiftPackageManager: [ // SPM 사용
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
```

#### 참고
> https://medium.com/@gitaeklee/ios-tuist-spm-%EB%8F%84%EC%9E%85-1-f351fe37d89e
> https://velog.io/@elile-e/Tuist-%EB%8F%84%EC%9E%85%ED%95%98%EA%B8%B0
> https://coding-rengar.tistory.com/50