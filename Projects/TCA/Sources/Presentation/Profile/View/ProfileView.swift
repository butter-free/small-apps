//
//  ProfileView.swift
//  TCAUITests
//
//  Created by sean on 2022/05/29.
//  Copyright © 2022 butterfree. All rights reserved.
//

import AppCore

import SwiftUI

import ComposableArchitecture

struct ProfileView: View {
  
  enum Size {
    static let thumbnail: CGFloat = 75
    static let userNameFont: CGFloat = 18
    static let userEmailFont: CGFloat = 16
    static let userStatusFont: CGFloat = 14
    static let editButtonFont: CGFloat = 16
  }
  
  var userInfo: UserInfo = .init()
  
  init(userInfo: UserInfo?) {
    if let userInfo = userInfo {
      self.userInfo = userInfo
    }
  }
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        HStack {
          AsyncImageView(url: .init(string: userInfo.thumbnail))
            .aspectRatio(contentMode: .fit)
            .cornerRadius(12)
            .frame(width: Size.thumbnail, height: Size.thumbnail, alignment: .center)
            .overlay(
              RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 0.5)
            )
          VStack(
            alignment: .leading,
            spacing: 8
          ) {
            Text(userInfo.name)
              .font(.system(size: Size.userNameFont, weight: .regular, design: .default))
              .foregroundColor(.black)
            Text(userInfo.email)
              .font(.system(size: Size.userEmailFont, weight: .regular, design: .default))
              .foregroundColor(.gray)
            Text(userInfo.bio)
              .font(.system(size: Size.userStatusFont, weight: .regular, design: .default))
              .foregroundColor(.gray)
          }
          .frame(
            maxWidth: .infinity,
            alignment: .leading
          )
        }.frame(
          minWidth: geometry.size.width,
          maxHeight: Size.thumbnail
        )
        
        HStack {
          Text("\(userInfo.followers) Followers - \(userInfo.following) Following")
            .font(.system(size: Size.userStatusFont, weight: .regular, design: .default))
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
          Button {
            print("click")
          } label: {
            Text("Edit")
              .font(.system(size: Size.editButtonFont, weight: .regular, design: .default))
              .foregroundColor(.gray)
              .frame(minWidth: 50, minHeight: 25)
          }
          .padding(.init(top: 4, leading: 10, bottom: 4, trailing: 10))
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.gray, lineWidth: 1)
          )
        }
        .frame(
          minWidth: geometry.size.width,
          maxHeight: Size.editButtonFont
        )
        Spacer()
          .frame(maxHeight: 20)
        Divider()
      } // VStack
    } // GeometryReader
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(userInfo: .init())
  }
}
