//
//  MainView.swift
//  TCA
//
//  Created by sean on 2022/03/08.
//

import Combine
import SwiftUI

struct MainView: View {
  
  enum Padding {
    static let SearchListViewBottom: CGFloat = 60
    static let StarredListViewBottom: CGFloat = 10
  }
  
  init() {
    let appearance = UITabBarAppearance()
    appearance.backgroundColor = .white
    appearance.shadowImage = nil
    appearance.shadowColor = nil
    UITabBar.appearance().standardAppearance = appearance
  }
  
  var body: some View {
    TabView {
      SearchListView()
        .padding(.init(top: 0, leading: 0, bottom: Padding.SearchListViewBottom, trailing: 0))
        .tabItem {
          Image(systemName: "flame.fill")
        }
      StarredListView()
        .padding(.init(top: 0, leading: 0, bottom: Padding.StarredListViewBottom, trailing: 0))
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
