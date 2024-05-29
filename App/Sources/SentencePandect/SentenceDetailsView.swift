//
//  SentenceDetailsView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import SwiftUI
import ComposableArchitecture

public struct SentenceDetailsView: View {
  
  let store: StoreOf<SentenceRow>
  
  public var body: some View {
    Text(store.sentence)
  }
  
  public init(store: StoreOf<SentenceRow>) {
    self.store = store
  }
}

struct SentenceDetails_Previews: PreviewProvider {
  static var previews: some View {
    SentenceDetailsView(
      store: Store(initialState: .mock) {
        SentenceRow()
      }
    )
  }
}

#Preview {
  SentenceDetailsView(
    store: Store(initialState: SentenceRow.State(id: UUID(), tagColor: Color.red, sentence: "sentence", time: Date())) {
      SentenceRow()
    }
  )
}
