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
  
  enum Padding {
    static let SearchListViewBottom: CGFloat = 60
    static let StarredListViewBottom: CGFloat = 10
  }
  
  @EnvironmentObject var router: ApplicationRouter
  @State private var selectionValue: Int = 0
  
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
    TabView(selection: $selectionValue) {
      SearchListView()
        .padding(.init(top: 0, leading: 0, bottom: Padding.SearchListViewBottom, trailing: 0))
        .tabItem {
          Image(systemName: "flame.fill")
        }
      
      StarredListView(userService: userService)
        .padding(.init(top: 0, leading: 0, bottom: Padding.StarredListViewBottom, trailing: 0))
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
          selectionValue = 0
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
}

//struct MainView_Previews: PreviewProvider {
//  static var previews: some View {
//    MainView(userService: UserManager.shared)
//  }
//}
