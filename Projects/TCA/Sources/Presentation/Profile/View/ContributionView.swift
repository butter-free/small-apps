//
//  ContributionView.swift
//  TCA
//
//  Created by sean on 2022/07/24.
//  Copyright © 2022 butterfree. All rights reserved.
//

import AppCore

import SwiftUI

struct RectangleView: View {
  
  var body: some View {
    switch contribution.level {
    case .less:
      Color.init(.init(red: 221/255, green: 224/255, blue: 228/255, alpha: 1)).edgesIgnoringSafeArea(.all)
    case .one:
      Color.init(.init(red: 140/255, green: 231/255, blue: 152/255, alpha: 1)).edgesIgnoringSafeArea(.all)
    case .two:
      Color.init(.init(red: 57/255, green: 187/255, blue: 81/255, alpha: 1)).edgesIgnoringSafeArea(.all)
    case .three:
      Color.init(.init(red: 42/255, green: 148/255, blue: 61/255, alpha: 1)).edgesIgnoringSafeArea(.all)
    default:
      Color.init(.init(red: 28/255, green: 93/255, blue: 43/255, alpha: 1)).edgesIgnoringSafeArea(.all)
    }
  }
  
  let contribution: Contribution
}

struct ContributionView: View {
  var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 6) {
        Text("올해에는 \(contributions.count)개의 commit을 기여중입니다.")
        ScrollView(
          .horizontal,
          showsIndicators: true
        ) {
          HStack(alignment: .center, spacing: 4) {
            ForEach(0 ..< contributions.count / 7, id: \.self) { index in
              VStack(alignment: .center, spacing: 4) {
                let startIndex = index * 7
                let endIndex = startIndex + 7
                ForEach(startIndex ..< endIndex, id: \.self) { offset in
                  RectangleView(contribution: contributions[offset])
                    .frame(width: 10, height: 10, alignment: .center)
                }
              }
            }
          }
        }
      }
    }
  }
  
  var contributions: [Contribution] = []
  
  init(contributions: [Contribution]) {
    self.contributions = contributions
    print(contributions)
  }
}
