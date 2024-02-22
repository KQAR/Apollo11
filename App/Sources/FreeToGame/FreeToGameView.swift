//
//  FreeToGameView.swift
//
//
//  Created by 金瑞 on 2023/12/8.
//

import SwiftUI
import ComposableArchitecture
import SFSafeSymbols

public struct FreeToGameView: View {
  
  let store: StoreOf<FreeToGameReducer>
  
  @Namespace private var animation
  
  private let columns = [GridItem(.adaptive(minimum: 300), spacing: 20)]
  
  public var body: some View {
    WithPerceptionTracking {
      ZStack {
        ScrollView(.vertical, showsIndicators: false) {
          
          HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 8) {
              Text("Today")
                .font(.title.bold())
              
              Text("22 November")
                .font(.callout.bold())
                .opacity(0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemSymbol: SFSymbol.homekit)
              .resizable()
              .scaledToFill()
              .frame(width: 40, height: 40)
              .clipShape(Circle())
              .padding(.vertical)
          }
          .padding(.horizontal)
          .opacity(store.currentShowItem == nil ? 1 : 0)
          
          LazyVGrid(columns: columns, spacing: 20) {
            ForEach(store.scope(state: \.games, action: \.row)) { rowStore in
              Button {
                store.send(
                  .selected(rowStore.state),
                  animation: .interactiveSpring(response: 0.6, dampingFraction: 1.0, blendDuration: 0.7)
                )
              } label: {
                GameRowView(store: rowStore, animation: animation, isSource: true)
                  .multilineTextAlignment(.leading)
                  .foregroundColor(.white)
                  .scaleEffect(store.currentShowItem?.id == rowStore.state.id ? 1 : 0.90)
              }
              .buttonStyle(ScaleButtonStyle())
              .opacity(store.currentShowItem?.id == rowStore.state.id ? 0 : 1)
            }
          }
        }
        .onAppear {
          store.send(.onAppear)
        }
      }
      
      if let showPageStore = store.scope(state: \.currentShowItem, action: \.showPageAction) {
        GameDetailView(store: showPageStore, animation: animation)
          .edgesIgnoringSafeArea(.top)
      }
    }
  }
  
  public init(store: StoreOf<FreeToGameReducer>) {
    self.store = store
  }
}

struct ScaleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.90 : 1)
      .animation(.easeInOut, value: configuration.isPressed)
  }
}

#Preview {
  FreeToGameView(
    store: Store(initialState: FreeToGameReducer.State(games: [])) {
      FreeToGameReducer()
    }
  )
}
