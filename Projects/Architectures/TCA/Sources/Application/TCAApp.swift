//
//  TCAApp.swift
//  TCA
//
//  Created by sean on 2022/03/08.
//

import SwiftUI
import Combine

import Core
import Firebase

let indicator = ActivityIndicator()

@main
struct TCAApp: App {
  
  let userService: UserService = UserManager.shared
  
  @ObservedObject var router = ApplicationRouter()
  
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $router.navigationPath) {
        routeToSignInView(userService: userService)
          .navigationDestination(for: ApplicationRouter.Destination.self) {
            switch $0 {
            case .signIn:
              routeToSignInView(userService: userService)
            case .main:
              MainView(userService: userService)
            }
          }
      }
      .environmentObject(router)
    }
  }
  
  init() {
    FirebaseApp.configure()
    
    indicator.loading
      .receive(on: DispatchQueue.main)
      .sink {
        print("isLoading: \($0)")
      }
  }
}

private extension TCAApp {
  func routeToSignInView(userService: UserService) -> SignInView {
    return SignInView(
      store: .init(
        initialState: SignInState(),
        reducer: signInReducer,
        environment: SignInEnvironment(
          userService: userService,
          signInUseCase: SignInDefaultUseCase(
            userInfoRepository: UserInfoDataRepository()
          ),
          mainQueue: DispatchQueue.main.eraseToAnyScheduler()
        )
      ),
      completion: {
        router.navigate(to: .main)
      }
    )
  }
}
