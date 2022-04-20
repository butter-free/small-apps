//
//  SearchListView.swift
//  TCA
//
//  Created by sean on 2022/04/19.
//

import SwiftUI

struct SearchItem: Identifiable, Codable {
  let id: Int
  let thumbnailURL: URL?
  let repositoryName: String
  let description: String
  let language: String
  let updatedDate: String
  let countOfStars: Int
  
  internal init(
    id: Int = 0,
    thumbnailURL: URL? = nil,
    repositoryName: String = "",
    description: String = "",
    language: String = "",
    updatedDate: String = "",
    countOfStars: Int = 0
  ) {
    self.id = id
    self.thumbnailURL = thumbnailURL
    self.repositoryName = repositoryName
    self.description = description
    self.language = language
    self.updatedDate = updatedDate
    self.countOfStars = countOfStars
  }
}

struct SearchListView: View {
  
  @State var searchedText: String = ""
  @State private var items: [SearchItem] = [.init(), .init()]
  
  var body: some View {
    VStack(spacing: 0) {
      SearchBar(searchText: searchedText)
      ScrollView(.vertical, showsIndicators: false) {
        ForEach(items, id: \.id) { item in
          SearchItemView(item: item) {
            print("tap")
          }.frame(width: .infinity, height: 160)
        }
      }
    }
  }
}

struct SearchListView_Previews: PreviewProvider {
  static var previews: some View {
    SearchListView()
  }
}
