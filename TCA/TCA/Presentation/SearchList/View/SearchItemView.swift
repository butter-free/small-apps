//
//  SearchItemView.swift
//  TCA
//
//  Created by sean on 2022/04/20.
//

import SwiftUI

struct SearchItemView: View {
  
  var didTapStarButton: () -> Void = {}
  
  let item: SearchItem
  
  init(item: SearchItem, didTapStarButton: (() -> Void)? = nil) {
    self.item = item
  }
  
  var body: some View {
    GeometryReader { geometry in
      Color.white
        VStack(spacing: 0) {
          HStack {
            Image(systemName: "person")
              .frame(width: 100, height: 100, alignment: .center)
              .overlay(
                RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1)
              )
            VStack(
              alignment: .leading,
              spacing: 8
            ){
              Text("Repository")
                .font(.system(size: 24, weight: .medium, design: .default))
              Text("Description")
                .font(.system(size: 16, weight: .regular, design: .default))
              Label("Swift", systemImage: "person")
                .font(.system(size: 14, weight: .regular, design: .default))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          }
          .frame(minHeight: 100, alignment: .top)
          
          HStack {
            Text("Updated")
              .font(.system(size: 16, weight: .regular, design: .default))
              .foregroundColor(.gray)
              .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            StarButton(didTapStarButton: didTapStarButton)
          }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          
          Divider()
        }.padding(.init(top: 12, leading: 12, bottom: 12, trailing: 12))
          .frame(width: geometry.size.width, height: 171, alignment: .top)
    }
  }
}

struct SearchItemView_Previews: PreviewProvider {
  static var previews: some View {
    SearchItemView(item: .init())
  }
}
