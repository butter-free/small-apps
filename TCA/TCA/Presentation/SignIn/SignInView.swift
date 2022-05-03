//
//  SignInView.swift
//  TCA
//
//  Created by sean on 2022/05/02.
//

import SwiftUI

import ComposableArchitecture
import FirebaseAuth
import FirebaseAuthCombineSwift

struct SignInView: View {
  
  let store: Store<SignInState, SignInAction>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack(spacing: 24) {
        Spacer()
        Image("ic_octor")
        Divider()
          .padding(.init(top: 0, leading: 50, bottom: 0, trailing: 50))
        Button {
          viewStore.send(.requestGithubSignIn)
        } label: {
          Image("btn_login")
        }
        Spacer()
      }
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView(
      store: .init(
        initialState: SignInState(),
        reducer: signInReducer,
        environment: SignInEnvironment(
          signInUseCase: SignInDefaultUseCase()
        )
      )
    )
  }
}
