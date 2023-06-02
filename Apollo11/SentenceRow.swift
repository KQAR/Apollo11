//
//  SentenceRow.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import SwiftUI
import Foundation
import ComposableArchitecture

struct SentenceRow: ReducerProtocol {
  
  struct State: Hashable, Identifiable {
    let id: UUID
    let tagColor: Color
    let sentence: String
    let time: Date
    var timeString: String {
      return time.timeOnlyWithPadding
    }
  }
  
  enum Action: Equatable { }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      return .none
    }
  }
}

extension SentenceRow.State {
  static var mock: Self {
    return Self(id: UUID(), tagColor: .blue, sentence: "Hello World", time: Date())
  }
}
