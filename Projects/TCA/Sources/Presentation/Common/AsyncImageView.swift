//
//  AsyncImageView.swift
//  TCA
//
//  Created by sean on 2022/04/26.
//

import SwiftUI

struct AsyncImageView: View {
  
  let url: URL?
  
  var body: some View {
    AsyncImage(
      url: url
    ) { image in
      image.resizable()
    } placeholder: {
      ProgressView()
    }
  }
}
