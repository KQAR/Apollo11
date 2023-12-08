//
//  File.swift
//  
//
//  Created by 金瑞 on 2023/12/8.
//

import SwiftUI
import ComposableArchitecture

public struct FreeToGameView: View {
  
  let store: StoreOf<FreeToGameReducer>
  
  public var body: some View {
    List {
      ForEachStore(
        self.store.scope(state: \.games, action: \.row)
      ) { rowStore in
        GameRowView(store: rowStore)
      }
    }
    .onAppear {
      self.store.send(.refresh)
    }
//    ScrollView {
//      LazyVGrid(columns: store.withState(\.gridItems), spacing: 20) {
//        ForEachStore(
//          self.store.scope(state: \.games, action: FreeToGameReducer.Action.row(id:action:))
//        ) { rowStore in
//          GameRowView(store: rowStore)
//        }
//      }
//    }
//    .onAppear {
//      self.store.send(.refresh)
//    }
  }
  
  public init(store: StoreOf<FreeToGameReducer>) {
    self.store = store
  }
}
