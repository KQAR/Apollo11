//
//  SentencePandectView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/4/28.
//

import SwiftUI
import ComposableArchitecture
import Introspect
import PopupView
import Popup

public struct SentencePandectView: View {
  
  let store: StoreOf<SentencePandect>
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      NavigationStack(
        path: viewStore.binding(
          get: \.path,
          send: SentencePandect.Action.navigationPathChanged
        )
      ) {
        List(
          viewStore.binding(get: \.sentences, send: SentencePandect.Action.update),
          editActions: [.delete, .move]
        ) { sentence in
          SentenceRowView(store: Store(initialState: sentence.wrappedValue, reducer: SentenceRow()))
            .background(NavigationLink(value: SentencePandect.State.Destination.child(sentence.wrappedValue)) {})
        }
        .navigationDestination(
          for: SentencePandect.State.Destination.self
        ) { destination in
          switch destination {
          case let .child(sentence):
            SentenceDetailsView(
              store: Store(initialState: sentence, reducer: SentenceRow())
            )
          }
        }
        .navigationTitle(viewStore.title)
        .safeAreaInset(edge: .bottom) {
          Spacer()
            .frame(maxHeight: 66)
        }
      }
      .alert(
        self.store.scope(state: \.alert),
        dismiss: .alertDismissed
      )
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
      store: Store(
        initialState: .mock,
        reducer: SentencePandect()
      )
    )
  }
}
