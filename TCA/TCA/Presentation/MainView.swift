//
//  MainView.swift
//  TCA
//
//  Created by sean on 2022/03/08.
//

import SwiftUI

struct MainView: View {
  
  @State private var text: String = ""
  
  enum Height {
    static let tabBar: CGFloat = UIDevice.current.hasNotch ? 110 : 80
  }
  
  init() {
    UITabBar.appearance().barTintColor = .systemBackground
    UITabBar.appearance().frame.size.height = Height.tabBar
    UITabBar.appearance().frame.origin.y = UIScreen.main.bounds.height - Height.tabBar
  }
  
  var body: some View {
    TabView {
      SearchListView()
        .searchable(text: $text)
        .tabItem {
          Image(systemName: "flame.fill")
        }
      Text("Second")
        .tabItem {
          Image(systemName: "star")
        }
      Text("Second")
        .tabItem {
          Image(systemName: "person")
        }
      Text("Second")
        .tabItem {
          Image(systemName: "gearshape")
        }
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
      
  }
}
