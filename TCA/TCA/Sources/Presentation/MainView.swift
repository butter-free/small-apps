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
  }
  
  init() {
    UITabBar.appearance().barTintColor = .white
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
      .edgesIgnoringSafeArea(.bottom)
      .padding(.init(top: 0, leading: 0, bottom: Padding.SearchListViewBottom, trailing: 0))
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
