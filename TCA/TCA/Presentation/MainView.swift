//
//  MainView.swift
//  TCA
//
//  Created by sean on 2022/03/08.
//

import Combine
import SwiftUI

struct MainView: View {
  
  enum Height {
    static let tabBar: CGFloat = UIDevice.current.hasNotch ? 80 : 50
  }
  
  @State private var text: String = ""
  
  init() {
    UITabBar.appearance().barTintColor = .white
    UITabBar.appearance().frame.size.height = Height.tabBar
    UITabBar.appearance().frame.origin.y = UIScreen.main.bounds.height - Height.tabBar
  }
  
  var body: some View {
    TabView {
      SearchListView(
        store: .init(
          initialState: SearchListState(),
          reducer: searchListReducer,
          environment: SearchListEnvironment(
            searchUseCase: SearchDefaultUseCase(
              repository: SearchDataRepository()
            ),
            mainQueue: DispatchQueue.main.eraseToAnyScheduler()
          )
        )
      )
      .searchable(text: $text)
      .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
      .tabItem {
        Image(systemName: "flame.fill")
      }
      Text("Second")
        .tabItem {
          Image(systemName: "star")
        }
      Text("Third")
        .tabItem {
          Image(systemName: "person")
        }
      Text("Fourth")
        .tabItem {
          Image(systemName: "gearshape")
        }
    }
    .background(Color.white)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
