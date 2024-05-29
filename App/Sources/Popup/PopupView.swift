//
//  PopupView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/26.
//

import SwiftUI
import ComposableArchitecture

public struct PopupView: View {

  @Bindable var store: StoreOf<PopupReducer>

  public var body: some View {
    ZStack {
      if store.flipped == false {
        VStack(alignment: .center, spacing: 8) {
          Spacer()

          Text(store.title ?? "")
            .bold()
            .foregroundColor(.black)

          Image(uiImage: store.image ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200, alignment: .center)
            .cornerRadius(8)
            .padding(15.0)

          Button {
            debugPrint("Accepted!")
            store.send(.flip)
          } label: {
            Text("Accept".uppercased())
              .font(.system(size: 14, weight: .black))
          }
          .buttonStyle(.borderedProminent)

          Spacer()
        }
      } else {
        VStack(alignment: .center, spacing: 8) {
          Text(store.text ?? "")
          Button {
            store.send(.copy)
          } label: {
            Text("copy".uppercased())
              .font(.system(size: 14, weight: .black))
          }
          .buttonStyle(.borderedProminent)
        }
        .padding(16)
        .rotation3DEffect(.degrees( -180.0), axis: (x: 0.0, y: 1.0, z: 0.0))
      }
    }
    .background(GradientEffectView($store.gradientModel.sending(\.updateGradientModel)))
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .frame(height: store.flipped ? 400 : 98)
    .padding(.horizontal, 16)
    .rotation3DEffect(Angle(degrees: store.flipped ? 180 : 0), axis: (x: 0, y: 1, z:0))
    .animation(.spring(dampingFraction: 0.9), value: store.flipped)
    .onTapGesture {
      store.send(.flip)
    }
    .onAppear {
      store.send(.updateGradient)
    }
  }
  
  public init(store: StoreOf<PopupReducer>) {
    self.store = store
  }
}
