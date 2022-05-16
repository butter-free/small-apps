//
//  RepositoryListView.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Combine
import SwiftUI

import ComposableArchitecture

enum RepositoryListViewType {
  case searchList, starredList
}

struct RepositoryListView: View {
  
  enum Height {
    static let itemView: CGFloat = 130
  }
  
  let viewType: RepositoryListViewType
  let store: Store<RepositoryListState, RepositoryListAction>
  var onSubmitQuerySubject: PassthroughSubject<String, Never> = .init()
  
  var body: some View {
    GeometryReader { geometry in
      WithViewStore(self.store) { viewStore in
        Color.white
        VStack(spacing: 0) {
          List {
            ForEach(viewStore.repositoryItemList, id: \.id) { item in
              RepositoryItemView(
                item: item,
                didTap: {
                  viewStore.send(.routeSafariView(item))
                },
                didTapStarButton: {
                  viewStore.send(.requestStar(viewType == .searchList ? .starred(item) : .unstar(item)))
                }
              )
              .sheet(
                item: viewStore.binding(
                  get: { $0.selectedItem },
                  send: .routeSafariView(nil)
                ),
                content: { item in
                  if let url = URL(string: item.url) {
                    SafariServiceView(url: url)
                  }
                }
              )
            }
            .background(Color.white)
            .listRowBackground(Color.white)
            .listRowSeparator(.hidden)
            .frame(maxWidth: .infinity, minHeight: Height.itemView)
          }
          .listStyle(PlainListStyle.plain)
          .edgesIgnoringSafeArea(.bottom)
          .frame(
            minWidth: geometry.size.width,
            minHeight: geometry.size.height
          )
        }
        .onAppear {
          // TODO: - Trending Api
          viewStore.send(.onAppear(viewType))
        }
        .sheet(
          isPresented: viewStore.binding(
            get: { $0.isPresentSignInView },
            send: .routeSignInView(.dismiss)
          ),
          content: {
            SignInView(
              store: .init(
                initialState: SignInState(),
                reducer: signInReducer,
                environment: SignInEnvironment(
                  userService: UserManager.shared,
                  signInUseCase: SignInDefaultUseCase(
                    userInfoRepository: UserInfoDataRepository()
                  ),
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              ),
              dismiss: {
                viewStore.send(.routeSignInView(.dismiss))
              }
            )
          }
        )
        .onReceive(onSubmitQuerySubject, perform: { query in
          viewStore.send(.requestRepositoryItemList(query))
        })
      }
    }
  }
}

struct RepositoryListView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoryListView(
      viewType: .searchList,
      store: Store(
        initialState: RepositoryListState(),
        reducer: repositoryListReducer,
        environment: RepositoryListEnvironment(
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
  }
}
