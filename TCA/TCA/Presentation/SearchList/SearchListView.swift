//
//  SearchListView.swift
//  TCA
//
//  Created by sean on 2022/04/19.
//

import SwiftUI

import ComposableArchitecture

struct SearchListView: View {
  
  enum Height {
    static let itemView: CGFloat = 130
  }
  
  @State var searchedText: String = ""
  @State private var selectedItem: SearchItem? = nil
  
  let store: Store<SearchListState, SearchListAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      GeometryReader { geometry in
        Color.white
        VStack(spacing: 0) {
          SearchBar(searchText: searchedText)
          Divider()
          List {
            ForEach(Array(viewStore.searchItemList), id: \.id) { item in
              SearchItemView(
                item: item,
                didTap: {
                  self.selectedItem = item
                },
                didTapStarButton: {
                  print("tap star button")
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
