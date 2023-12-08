// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Debug
import ComposableArchitecture

@Reducer
public struct FreeToGameReducer {
  
  @ObservableState
  public struct State {
    var games: IdentifiedArrayOf<GameRowReducer.State>
    var gridItems: [GridItem]
    var error: String?
    
    public init(games: IdentifiedArrayOf<GameRowReducer.State>, error: String? = nil) {
      self.gridItems = Array(repeating: GridItem(), count: games.count)
      self.games = games
      self.error = error
    }
  }
  
  public enum Action {
    case refresh
    case set([FreeGame])
    case show(error: String?)
    case row(IdentifiedActionOf<GameRowReducer>)
  }
  
  let network = FreeToGameApi.shared
  
  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .refresh:
        return .run { send in
          let result = await network.fetchGamesList()
          switch result {
          case let .success(list):
            await send(.set(list))
          case let .failure(error):
            await send(.show(error: error.errorDescription))
          }
        }
      case let .set(list):
        state.gridItems = Array(repeating: .init(.flexible()), count: list.count)
        state.games = IdentifiedArray(uniqueElements: list.map {  GameRowReducer.State(id: UUID(), game: $0) })
        return .none
      case let .show(error):
        state.error = error
        return .none
      case .row:
        return .none
      }
    }
    .forEach(\.games, action: \.row) {
      GameRowReducer()
    }
  }
  
  public init() {}
}
