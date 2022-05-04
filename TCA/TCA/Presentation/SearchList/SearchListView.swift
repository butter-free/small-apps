//
//  SearchListView.swift
//  TCA
//
//  Created by sean on 2022/04/19.
//

import SwiftUI

import ComposableArchitecture
import FirebaseAuth

struct SearchListView: View {
  
  enum Height {
    static let itemView: CGFloat = 130
  }
  
  @State var searchedText: String = ""
  @State private var selectedItem: SearchItem? = nil
  @State private var isPresentSignInView: Bool = false
  
  let store: Store<SearchListState, SearchListAction>
  
  var body: some View {
    GeometryReader { geometry in
      WithViewStore(self.store) { viewStore in
        Color.white
        VStack(spacing: 0) {
          SearchBar(searchText: $searchedText)
            .onSubmit {
              viewStore.send(.requestSearchItemList(searchedText))
            }
          Divider()
          List {
            ForEach(viewStore.searchItemList, id: \.id) { item in
              SearchItemView(
                item: item,
                didTap: {
                  self.selectedItem = item
                },
                didTapStarButton: {
                  // TODO: - Login & Starred
                  print("tap star button")
                  if let _ = Auth.auth().currentUser {
                    
                  } else {
                    isPresentSignInView = true
                  }
                }
              )
              .sheet(item: $selectedItem, onDismiss: dismissSheet) { item in
                if let url = URL(string: item.repositoryURLString) {
                  SafariServiceView(url: url)
                }
              }
            }
            .background(Color.white)
            .listRowBackground(Color.white)
            .listRowSeparator(.hidden)
            .frame(maxWidth: .infinity, minHeight: Height.itemView)
          }
          .listStyle(PlainListStyle.plain)
          .edgesIgnoringSafeArea(.all)
          .frame(
            minWidth: geometry.size.width,
            minHeight: geometry.size.height
          )
        }
        .onAppear {
          // TODO: - Trending Api
          viewStore.send(SearchListAction.requestSearchItemList("swift"))
        }
      }
      .sheet(isPresented: $isPresentSignInView) {
        SignInView(
          store: .init(
            initialState: SignInState(),
            reducer: signInReducer,
            environment: SignInEnvironment(
              signInUseCase: SignInDefaultUseCase()
            )
          )
        )
      }
    }
  }
  
  func dismissSheet() {
    selectedItem = nil
  }
}

struct SearchListView_Previews: PreviewProvider {
  static var previews: some View {
    SearchListView(
      store: Store(
        initialState: SearchListState(),
        reducer: searchListReducer,
        environment: SearchListEnvironment(
          searchUseCase: SearchDefaultUseCase(
            repository: SearchDataRepository()
          ),
          mainQueue: DispatchQueue.main.eraseToAnyScheduler())
      )
    )
  }
}
