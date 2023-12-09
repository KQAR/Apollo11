//
//  GameRowReducer.swift
//  
//
//  Created by Jarvis on 2023/9/18.
//

import SwiftUI
import ComposableArchitecture

@Reducer
public struct GameRowReducer {
  
  @ObservableState
  public struct State: Equatable, Identifiable {
    public let id: UUID
    let game: FreeGame
    var isAnimationView: Bool = false
  }
  
  public enum Action {
    case show
    case close
  }
  
  public func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .show:
      state.isAnimationView = true
      return .none
    case .close:
      state.isAnimationView = false
      return .none
    }
  }
}
