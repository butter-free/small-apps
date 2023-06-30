//
//  SignInView.swift
//  TCA
//
//  Created by sean on 2022/05/02.
//

import SwiftUI

import Core
import ComposableArchitecture

struct SignInView: View {
  
  let store: Store<SignInState, SignInAction>
  var completion: () -> Void
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: 24) {
        Spacer()
        Image("ic_octor")
        Divider()
          .padding(.init(top: 0, leading: 50, bottom: 0, trailing: 50))
        Button {
          viewStore.send(.requestSignIn)
        } label: {
          Image("btn_login")
        }
        Spacer()
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
        "Success Sign In!",
        isPresented: viewStore.binding(
          get: { $0.isPresentSignInAlert },
          send: .routeSignInAlert(.dismiss)
        ),
        actions: {
          Button("Confirm") { completion() }
        }
      )
    }
  }
}
