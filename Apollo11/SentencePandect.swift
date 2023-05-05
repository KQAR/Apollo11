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
    var sentences: IdentifiedArrayOf<SentenceRow.State>
  }
  
  enum Action {
    
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      return .none
    }
  }
}
