//
//  MainView.swift
//  TCA
//
//  Created by sean on 2022/03/08.
//

import Core

import Combine
import Foundation
import SwiftUI

struct MainView: View {
  
  @EnvironmentObject var router: ApplicationRouter
  
  private let userService: UserService
  
  init(userService: UserService) {
    self.userService = userService
    
    let appearance = UITabBarAppearance()
    appearance.backgroundColor = .white
    appearance.shadowImage = nil
    appearance.shadowColor = nil
    UITabBar.appearance().standardAppearance = appearance
  }
  
  var body: some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      MainTabView(userService: userService)
        .environmentObject(router)
    } else {
      MainNavigationSplitView(userService: userService)
        .environmentObject(router)
    }
  }
}

struct MainTabView: View {
  
  enum Padding {
    static let searchListViewBottom: CGFloat = 60
    static let starredListViewBottom: CGFloat = 10
  }
  
  @EnvironmentObject var router: ApplicationRouter
  
  private let userService: UserService
  
  var body: some View {
    TabView {
      SearchListView()
        .padding(.init(top: 0, leading: 0, bottom: Padding.searchListViewBottom, trailing: 0))
        .tabItem {
          Image(systemName: "flame.fill")
        }
      
      StarredListView(userService: userService)
        .padding(.init(top: 0, leading: 0, bottom: Padding.starredListViewBottom, trailing: 0))
        .tabItem {
          Image(systemName: "star")
        }
      
      ProfileContainerView(
        store: .init(
          initialState: .init(),
          reducer: profileContainerReducer,
          environment: .init(userService: userService)
        ))
      .tabItem {
        Image(systemName: "person")
      }
      
      SettingsContainerView(
        store: .init(
          initialState: .init(),
          reducer: settingsReducer,
          environment: .init(
            userService: userService,
            signOutUseCase: SignOutDefaultUseCase(),
            mainQueue: DispatchQueue.main.eraseToAnyScheduler()
          )
        ),
        dismiss: {
          router.navigateToRoot()
        }
      )
      .tabItem {
        Image(systemName: "gearshape")
      }
    }
    .navigationBarBackButtonHidden(true)
    .background(Color.white)
  }
  
  init(userService: UserService) {
    self.userService = userService
  }
}

struct MainNavigationSplitView: View {
  
  @EnvironmentObject var router: ApplicationRouter
  @State private var menuType: MenuType? = .search
  
  private let userService: UserService
  
  var body: some View {
    NavigationSplitView {
      List(MenuType.allCases, selection: $menuType) { type in
        NavigationLink(value: type) {
          Label(type.rawValue, systemImage: type.imageName)
        }
      }
    } detail: {
      switch menuType {
        
      case .search:
        NavigationStackBuilder {
          SearchListView()
        }
        
      case .starred:
        NavigationStackBuilder {
          StarredListView(userService: userService)
        }
        
      case .profile:
        NavigationStackBuilder {
          ProfileContainerView(
            store: .init(
              initialState: .init(),
              reducer: profileContainerReducer,
              environment: .init(userService: userService)
            ))
        }
        
      default:
        NavigationStackBuilder {
          SettingsContainerView(
            store: .init(
              initialState: .init(),
              reducer: settingsReducer,
              environment: .init(
                userService: userService,
                signOutUseCase: SignOutDefaultUseCase(),
                mainQueue: DispatchQueue.main.eraseToAnyScheduler()
              )
            ),
            dismiss: {
              router.navigateToRoot()
            }
          )
        }
      }
    }
    .navigationBarBackButtonHidden()
  }
  
  init(userService: UserService) {
    self.userService = userService
  }
}

struct NavigationStackBuilder<Content>: View where Content: View {
  
  let navigationBarHidden: Bool
  let content: () -> Content
  
  var body: some View {
    NavigationStack {
      content()
    }
    .navigationBarHidden(navigationBarHidden)
  }
  
  init(
    navigationBarHidden: Bool = true,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.navigationBarHidden = navigationBarHidden
    self.content = content
  }
}

//struct MainView_Previews: PreviewProvider {
//  static var previews: some View {
//    MainView(userService: UserManager.shared)
//  }
//}
