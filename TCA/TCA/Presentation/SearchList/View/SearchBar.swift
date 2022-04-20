//
//  SearchBar.swift
//  TCA
//
//  Created by sean on 2022/04/20.
//

import SwiftUI

struct SearchBar: View {
  
  @State var searchText: String = ""
  
  var body: some View {
    ZStack {
      Color.white
      HStack {
        HStack {
          Image(systemName: "magnifyingglass")
            .foregroundColor(Color.black)
          
          TextField("", text: $searchText)
            .accentColor(.white)
            .foregroundColor(.white)
        }
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        .background(Color.gray.opacity(0.3))
        .cornerRadius(8)
        
        Button(action: {
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }, label: {
          Text("Cancel")
        })
        .accentColor(Color.gray.opacity(0.5))
        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 8))
      }
      .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
    .frame(height: 50)
  }
}
