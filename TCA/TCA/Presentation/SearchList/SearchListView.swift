//
//  SearchListView.swift
//  TCA
//
//  Created by sean on 2022/04/19.
//

import SwiftUI

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
