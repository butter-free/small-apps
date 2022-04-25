//
//  SafariServiceView.swift
//  TCA
//
//  Created by sean on 2022/04/25.
//

import SafariServices
import SwiftUI
import UIKit

struct SafariServiceView: UIViewControllerRepresentable {
  
  let url: URL
  
  init(url: URL) {
    self.url = url
    print(url)
  }

  func makeUIViewController(context: UIViewControllerRepresentableContext<SafariServiceView>) -> SFSafariViewController {
      return SFSafariViewController(url: url)
  }

  func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariServiceView>) {

  }
}
