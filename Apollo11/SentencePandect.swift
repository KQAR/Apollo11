//
//  SentencePandect.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import Foundation
import ComposableArchitecture

struct SentencePandect: ReducerProtocol {
  
  struct State: Equatable {
    enum Destination: Hashable {
      case child(SentenceRow.State)
    }
    var title = "Sentences"
    var path: [Destination] = []
    var sentences: IdentifiedArrayOf<SentenceRow.State>
  }
  
  enum Action {
    case navigationPathChanged([State.Destination])
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .navigationPathChanged(path):
        state.path = path
        return .none
      }
    }
  }
}
