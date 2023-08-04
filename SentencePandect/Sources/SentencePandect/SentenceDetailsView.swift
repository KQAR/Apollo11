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
    WithViewStore(store, observe: { $0 }) { viewStore in
      Text(viewStore.sentence)
    }
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
