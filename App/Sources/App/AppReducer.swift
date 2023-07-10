//
//  AppReducer.swift
//  Apollo11
//
//  Created by Jarvis on 2023/6/5.
//

import ComposableArchitecture
import SFSafeSymbols
import SentencePandect

public struct AppReducer: ReducerProtocol {
  
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
    
    public init() {}
  }
  
  public enum Action: BindableAction {
   case binding(BindingAction<State>)
    
    case home(SentencePandect.Action)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.home, action: /Action.home) {
      SentencePandect()
    }
    BindingReducer()
    Reduce { state, action in
      return .none
    }
  }
  
  public init() {}
}
