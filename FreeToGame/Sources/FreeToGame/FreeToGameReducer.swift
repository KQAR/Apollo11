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
    var currentShowItem: GameRowReducer.State?
    var error: String?
    var isLoaded: Bool = false
    
    public init(games: IdentifiedArrayOf<GameRowReducer.State>, error: String? = nil) {
      self.gridItems = Array(repeating: GridItem(), count: games.count)
      self.games = games
      self.error = error
    }
  }
  
  public enum Action {
    case refresh
    case onAppear
    case set([FreeGame])
    case show(error: String?)
    case row(IdentifiedActionOf<GameRowReducer>)
    case selected(GameRowReducer.State?)
    case showPageAction(GameRowReducer.Action)
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
            printLog("fetch gameslist success")
            await send(.set(list))
          case let .failure(error):
            printLog("fetch gameslist failure")
            await send(.show(error: error.errorDescription))
          }
        }
      case .onAppear:
        guard state.isLoaded == false else {
          return .none
        }
        return .send(.refresh)
      case let .set(list):
        state.gridItems = Array(repeating: .init(.flexible()), count: list.count)
        state.games = IdentifiedArray(uniqueElements: list.map {  GameRowReducer.State(id: UUID(), game: $0) })
        state.isLoaded = true
        return .none
      case let .show(error):
        state.error = error
        return .none
      case let .selected(currentItem):
        var item = currentItem
        item?.isAnimationView = true
        state.currentShowItem = item
        return .none
      case let .showPageAction(action):
        switch action {
        case .close:
          state.currentShowItem = nil
        default:
          break
        }
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
