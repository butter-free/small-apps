//
//  StarButton.swift
//  TCA
//
//  Created by sean on 2022/04/20.
//

import SwiftUI

struct StarButton: View {
  
  var didTapStarButton: () -> Void = {}
  
  var body: some View {
    Button(action: didTapStarButton) {
      Text("9k Star")
        .font(.system(size: 16, weight: .medium, design: .default))
        .foregroundColor(.gray)
        .padding(.init(top: 8, leading: 10, bottom: 8, trailing: 10))
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .stroke(Color.gray, lineWidth: 1)
        )
    }
    .cornerRadius(12)
  }
}

struct StarButton_Previews: PreviewProvider {
  static var previews: some View {
    StarButton()
  }
}
