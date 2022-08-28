//
//  ProfileContainerView.swift
//  TCAUITests
//
//  Created by sean on 2022/06/07.
//  Copyright © 2022 butterfree. All rights reserved.
//

import AppCore

import SwiftUI

import ComposableArchitecture

struct ProfileContainerView: View {
  
  let store: Store<ProfileContainerState, ProfileContainerAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        ProfileView(userInfo: viewStore.userInfo)
          .frame(maxHeight: 128)
        if !viewStore.contributions.isEmpty {
          ContributionView(
            contributions: viewStore.contributions
          )
        }
        
        Spacer()
      }
      .padding(.init(top: 12, leading: 12, bottom: 0, trailing: 12))
      .onAppear {
        viewStore.send(.onAppear)
      }
    }
  }
}

struct ProfileContainerView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileContainerView(
      store: .init(
        initialState: .init(),
        reducer: profileContainerReducer,
        environment: .init(
          userService: UserManager.shared
        )
      )
    )
  }
}
