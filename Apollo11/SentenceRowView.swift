//
//  SentenceRowView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import SwiftUI
import ComposableArchitecture

struct SentenceRowView: View {
  
  let store: StoreOf<SentenceRow>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        Text(viewStore.sentence)
          .fontWeight(.medium)
        Spacer()
      }
      .padding(15)
      .background(Color.yellow)
    }
  }
}

struct SentenceRow_Previews: PreviewProvider {
  static var previews: some View {
    SentenceRowView(
      store: Store(
        initialState: SentenceRow.State(id: UUID(), sentence: "hello, sententce"),
        reducer: SentenceRow()
      )
    )
  }
}
