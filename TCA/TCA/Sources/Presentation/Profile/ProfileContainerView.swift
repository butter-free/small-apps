//
//  ProfileContainerView.swift
//  TCAUITests
//
//  Created by sean on 2022/06/07.
//  Copyright © 2022 butterfree. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct ProfileContainerView: View {
  
  let store: Store<ProfileContainerState, ProfileContainerAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      ProfileView(userInfo: viewStore.userInfo)
        .padding(.init(top: 12, leading: 12, bottom: 0, trailing: 12))
    }
  }
}

struct ProfileContainerView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileContainerView(
      store: .init(
        initialState: .init(),
        reducer: profileContainerReducer,
        environment: .init(userService: UserManager.shared)
      )
    )
  }
}
