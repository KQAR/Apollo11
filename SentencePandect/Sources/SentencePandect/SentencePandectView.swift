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
  
  let store: StoreOf<SentencePandect>
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      NavigationStack(
        path: viewStore.binding(
          get: \.path,
          send: SentencePandect.Action.navigationPathChanged
        )
      ) {
        List {
          ForEachStore(
            self.store.scope(state: \.sentences, action: SentencePandect.Action.sentenceRow(id:action:))
          ) { rowStore in
            WithViewStore(rowStore, observe: { $0 }) { rowViewStore in
              SentenceRowView(store: rowStore)
                .background(NavigationLink(value: SentencePandect.State.Destination.child(rowViewStore.state)) {})
            }
          }
          .onDelete { viewStore.send(.delete($0)) }
          .onMove { viewStore.send(.move($0, $1)) }
        }
        .navigationDestination(
          for: SentencePandect.State.Destination.self
        ) { destination in
          switch destination {
          case let .child(sentence):
            SentenceDetailsView(
              store: Store(initialState: sentence) {
                SentenceRow()
              }
            )
          }
        }
        .navigationTitle(viewStore.title)
        .safeAreaInset(edge: .bottom) {
          Spacer()
            .frame(maxHeight: 66)
        }
      }
      .alert(store: self.store.scope(state: \.$alert, action: { .alert($0) }))
      .popup(isPresented: viewStore.binding(
        get: \.popupViewIsShowing,
        send: SentencePandect.Action.popupViewHidden)
      ) {
        PopupView(store: self.store.scope(state: \.popupViewState, action: SentencePandect.Action.popupAction))
      } customize: {
        $0.type(.default)
          .animation(.spring())
      }
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
        viewStore.send(.pasteboardCheck)
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
