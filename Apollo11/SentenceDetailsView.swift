//
//  SentenceDetailsView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import SwiftUI
import ComposableArchitecture

struct SentenceDetailsView: View {
  
  let store: StoreOf<SentenceRow>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      Text(viewStore.sentence)
    }
  }
}

struct SentenceDetails_Previews: PreviewProvider {
  static var previews: some View {
    SentenceDetailsView(
      store: Store(
        initialState: SentenceRow.State(id: UUID(), sentence: "feijiji"),
        reducer: SentenceRow()
      )
    )
  }
}
