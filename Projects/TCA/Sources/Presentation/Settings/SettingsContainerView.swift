//
//  SettingsContainerView.swift
//  TCA
//
//  Created by sean on 2022/08/08.
//

import Combine
import SwiftUI

import ComposableArchitecture

struct SettingsContainerView: View {
  
  let store: Store<SettingsState, SettingsAction>
  var dismiss: () -> Void
  
    var body: some View {
      GeometryReader { geometry in
        WithViewStore(self.store) { viewStore in
          Color.white
          VStack {
            Button {
              viewStore.send(.requestSignOut)
            } label: {
              Text("Logout")
                .fontWeight(.semibold)
                .foregroundColor(.red)
            }.frame(height: 50)

            Divider()
          }
          .alert(
            viewStore.state.networkError?.localizedDescription ?? "",
            isPresented: viewStore.binding(
              get: { $0.networkError != nil },
              send: .routeErrorAlert(nil)
            ),
            actions: {
              Button("Confirm") {}
            }
          )
          .alert(
            "Success Sign Out!",
            isPresented: viewStore.binding(
              get: { $0.isPresentSignInAlert },
              send: .routeSignOutAlert(.dismiss)
            ),
            actions: {
              Button("Confirm") { dismiss() }
            }
          )
          .frame(
            width: geometry.size.width,
            alignment: .center
          )
        }
      }
    }
}
