//
//  File.swift
//  
//
//  Created by Jarvis on 2023/9/18.
//

import SwiftUI
import ComposableArchitecture
import Kingfisher

@Reducer
public struct GameRowReducer {
  
  @ObservableState
  public struct State: Equatable, Identifiable {
    public let id: UUID
    let game: FreeGame
  }
  
  public enum Action {}
  
  public func reduce(into state: inout State, action: Action) -> Effect<Action> {
    return .none
  }
}

struct GameRowView: View {
  
  let store: StoreOf<GameRowReducer>
  
  var body: some View {
    WithPerceptionTracking {
      HStack {
        KFImage(URL(string: store.game.thumbnail))
          .resizable()
          .frame(width: 90, height: 70)
          .scaledToFit()
        VStack(alignment: .leading) {
          Text(store.game.short_description)
            .font(.system(size: 16))
          Text(store.game.publisher)
            .font(.system(size: 10))
            .lineLimit(1)
        }
        Spacer()
      }
      .frame(height: 80)
      .padding(.vertical, 5)
    }
  }
}

#Preview {
  GameRowView(
    store: Store(initialState: GameRowReducer.State(id: UUID(), game: .mock)) {
      GameRowReducer()
    }
  )
}
