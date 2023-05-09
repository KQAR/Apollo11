//
//  SentenceRow.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import Foundation
import ComposableArchitecture

struct SentenceRow: ReducerProtocol {
  
  struct State: Hashable, Identifiable {
    let id: UUID
    let sentence: String
  }
  
  enum Action: Equatable { }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      return .none
    }
  }
}