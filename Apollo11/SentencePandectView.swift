//
//  SentencePandectView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/4/28.
//

import SwiftUI
import ComposableArchitecture
import Introspect

let sentences = IdentifiedArrayOf(uniqueElements: [
  SentenceRow.State(id: UUID(), sentence: "Learning how to query loaded code is essential for learning how to create breakpoints on that code. "),
  SentenceRow.State(id: UUID(), sentence: "Both Objective-C and Swift have specific property signatures when they’re created by the compiler, which results in different querying strategies when looking for code."),
  SentenceRow.State(id: UUID(), sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.")
])

struct SentencePandectView: View {
  
  let store: StoreOf<SentencePandect>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationStack(
        path: viewStore.binding(
          get: \.path,
          send: SentencePandect.Action.navigationPathChanged
        )
      ) {
        List(viewStore.sentences) { sentence in
          SentenceRowView(store: Store(initialState: sentence, reducer: SentenceRow()))
            .background(NavigationLink(value: SentencePandect.State.Destination.child(sentence)) {})
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
      }
    }
  }
}

struct SentencePandectView_Previews: PreviewProvider {
  static var previews: some View {
    SentencePandectView(
      store: Store(
        initialState: SentencePandect.State(sentences: sentences),
        reducer: SentencePandect()
      )
    )
  }
}
