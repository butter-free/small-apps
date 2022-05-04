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
          SearchBar(searchText: searchedText)
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
                  if let user = Auth.auth().currentUser {
                    print(user)
                    print(user.email)
                    print(user.displayName)
                  } else {
                    isPresentSignInView = true
                  }
                }
              )
              .listRowBackground(Color.white)
              .listRowSeparator(.hidden)
              .edgesIgnoringSafeArea(.all)
              .frame(height: Height.itemView)
              .sheet(item: $selectedItem, onDismiss: dismissSheet) { item in
                if let url = URL(string: item.repositoryURLString) {
                  SafariServiceView(url: url)
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
          .background(Color.white)
          .listStyle(PlainListStyle())
          .edgesIgnoringSafeArea(.all)
          .frame(maxWidth: .infinity)
        }
      }.onAppear {
        viewStore.send(SearchListAction.requestSearchItemList("swift"))
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
