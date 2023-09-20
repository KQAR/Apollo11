//
//  AppReducer.swift
//  Apollo11
//
//  Created by Jarvis on 2023/6/5.
//

import ComposableArchitecture
import SFSafeSymbols
import SentencePandect
import FreeToGame

public struct AppReducer: Reducer {
  
  enum Tab: String, CaseIterable {
    case home
    case calendar
    case setting
    
    var icon: SFSymbol {
      switch self {
      case .home:
        return .house
      case .calendar:
        return .calendar
      case .setting:
        return .gear
      }
    }
    
    var selectedIcon: SFSymbol {
      return icon
    }
    
    var title: String {
      return self.rawValue
    }
  }
  
  public struct State {
    @BindingState
    var tab = Tab.home
    
    var home = SentencePandect.State.mock
    var freeGames = FreeToGameReducer.State(games: [])
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case home(SentencePandect.Action)
    case freeGames(FreeToGameReducer.Action)
  }
  
  public var body: some Reducer<State, Action> {
    Scope(state: \.home, action: /Action.home) {
      SentencePandect()
    }
    Scope(state: \.freeGames, action: /Action.freeGames) {
      FreeToGameReducer()
    }
    BindingReducer()
    Reduce { state, action in
      return .none
    }
  }
  
  public init() {}
}
