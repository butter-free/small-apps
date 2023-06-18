//
//  SearchListView.swift
//  TCA
//
//  Created by sean on 2022/04/19.
//

import Core

import Combine
import SwiftUI

import ComposableArchitecture
import FirebaseAuth

struct SearchListView: View {
  
  @State var searchedText: String = ""
  
  var querySubject = PassthroughSubject<String, Never>()
  
  var body: some View {
    GeometryReader { geometry in
        Color.white
        VStack(spacing: 0) {
          SearchBar(searchText: $searchedText)
            .onSubmit {
              querySubject.send(searchedText)
            }
          RepositoryListView(
            store: .init(
              initialState: .init(),
              reducer: repositoryListReducer,
              environment: .init(
                viewType: .searchList,
                userService: UserManager.shared,
                searchUseCase: SearchDefaultUseCase(
                  searchRepository: SearchDataRepository()
                ),
                starredUseCase: StarredDefaultUseCase(
                  starredRepository: StarredDataRepository()
                ),
                mainQueue: DispatchQueue.main.eraseToAnyScheduler()
              )
            ),
            onSubmitQuerySubject: querySubject
          )
          .frame(
            minWidth: geometry.size.width,
            minHeight: geometry.size.height
          )
          Divider()
        }
    }
  }
}
