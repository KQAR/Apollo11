//
//  SentenceRow.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import SwiftUI
import Foundation
import ComposableArchitecture
import Extensions

public struct SentenceRow: Reducer {
  
  public struct State: Hashable, Identifiable {
    public let id: UUID
    public let tagColor: Color
    public let sentence: String
    public let time: Date
    public var timeString: String {
      return time.timeOnlyWithPadding
    }
  }
  
  public enum Action: Equatable {
    case delete
  }
  
  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .delete:
        return .none
      }
    }
  }
  
  public init() {}
}

extension SentenceRow.State {
  static var mock: Self {
    return Self(id: UUID(), tagColor: .blue, sentence: "Hello World", time: Date())
  }
}
