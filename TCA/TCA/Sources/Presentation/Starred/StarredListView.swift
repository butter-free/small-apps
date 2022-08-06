//
//  StarredListView.swift
//  TCA
//
//  Created by sean on 2022/05/11.
//  Copyright © 2022 sample. All rights reserved.
//

import SwiftUI

import ComposableArchitecture
import FirebaseAuth

struct StarredListView: View {
  
  var body: some View {
    GeometryReader { geometry in
      Color.white
      VStack(spacing: 0) {
        RepositoryListView(
          store: Store(
            initialState: RepositoryListState(),
            reducer: repositoryListReducer,
            environment: RepositoryListEnvironment(
              viewType: .starredList,
              userService: UserManager.shared,
              searchUseCase: SearchDefaultUseCase(
                searchRepository: SearchDataRepository()
              ),
              starredUseCase: StarredDefaultUseCase(
                starredRepository: StarredDataRepository()
              ),
              mainQueue: DispatchQueue.main.eraseToAnyScheduler()
            )
          )
        )
        Divider()
      }
    }
  }
}

struct StarredListView_Previews: PreviewProvider {
  static var previews: some View {
    StarredListView()
  }
}
