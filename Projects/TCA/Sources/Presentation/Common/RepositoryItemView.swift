//
//  RepositoryItemView.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import AppCore

import SwiftUI

struct RepositoryItemView: View {
  
  enum Size {
    static let thumbnail: CGFloat = 75
    static let repositoryNameFont: CGFloat = 18
    static let descriptionFont: CGFloat = 16
    static let languageFont: CGFloat = 14
    static let updatedDateFont: CGFloat = 16
    static let viewHeight: CGFloat = 130
  }
  
  let item: RepositoryItem
  var didTap: (() -> Void)?
  var didTapStarButton: (() -> Void)?
  
  var body: some View {
    GeometryReader { geometry in
      Color.white
      VStack(spacing: 0) {
        HStack {
          AsyncImageView(url: URL(string: item.owner.thumbnailURLString))
            .aspectRatio(contentMode: .fit)
            .cornerRadius(12)
            .frame(width: Size.thumbnail, height: Size.thumbnail, alignment: .center)
            .overlay(
              RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 0.5)
            )
          VStack(
            alignment: .leading,
            spacing: 8
          ){
            Text(item.repositoryName)
              .font(.system(size: Size.repositoryNameFont, weight: .semibold, design: .default))
              .foregroundColor(.black)
            Text(item.description)
              .font(.system(size: Size.descriptionFont, weight: .regular, design: .default))
              .foregroundColor(.gray)
            Text(item.language)
              .font(.system(size: Size.languageFont, weight: .regular, design: .default))
              .foregroundColor(.gray)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        HStack {
          Text(item.updatedDate)
            .font(.system(size: Size.updatedDateFont, weight: .regular, design: .default))
            .foregroundColor(.gray)
            .frame(alignment: .leading)
          Spacer()
          StarButton(numberOfStars: item.numberOfStars, isStarred: item.isStarred)
            .onTapGesture {
              didTapStarButton?()
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
      }
      .onTapGesture {
        didTap?()
      }
      .frame(width: geometry.size.width, height: Size.viewHeight, alignment: .top)
    }
  }
}

struct RepositoryItemView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoryItemView(item: .init())
  }
}
