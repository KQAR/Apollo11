//
//  SentencePandectView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/4/28.
//

import SwiftUI
import ComposableArchitecture
import PopupView
import Popup

public struct SentencePandectView: View {
  
  @BindableStore var store: StoreOf<SentencePandect>
  
  public var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
        List {
          ForEach(store.scope(state: \.sentences, action: \.sentenceRow)) { rowStore in
            NavigationLink(state: rowStore.state) {
              SentenceRowView(store: rowStore)
            }
          }
          .onDelete { store.send(.delete($0)) }
          .onMove { store.send(.move($0, $1)) }
        }
        .navigationTitle(store.title)
        .safeAreaInset(edge: .bottom) {
          Spacer()
            .frame(maxHeight: 66)
        }
      } destination: { store in
        SentenceDetailsView(store: store)
      }
      .alert(store: store.scope(state: \.$alert, action: \.alert))
      .popup(isPresented: $store.popupViewIsShowing.sending(\.popupViewHidden)) {
        PopupView(store: store.scope(state: \.popupViewState, action: \.popupAction))
      } customize: {
        $0.type(.default).animation(.spring())
      }
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
        store.send(.pasteboardCheck)
      }
    }
  }
  
  public init(store: StoreOf<SentencePandect>) {
    self.store = store
  }
}

struct SentencePandectView_Previews: PreviewProvider {
  static var previews: some View {
    SentencePandectView(
      store: Store(initialState: .mock) {
        SentencePandect()
      }
    )
  }
}
