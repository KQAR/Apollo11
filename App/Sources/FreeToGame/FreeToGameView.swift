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
  
  public var body: some View {
    WithPerceptionTracking {
      ScrollView(.vertical, showsIndicators: false) {
        LazyVStack {
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
          
          ForEach(store.scope(state: \.games, action: \.row)) { rowStore in
            Button {
              store.send(
                .selected(rowStore.state),
                animation: .interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)
              )
            } label: {
              GameRowView(store: rowStore)
                .matchedGeometryEffect(id: rowStore.state.id, in: animation)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                .scaleEffect(store.currentShowItem?.id == rowStore.state.id ? 1 : 0.90)
            }
            .buttonStyle(ScaleButtonStyle())
            .opacity(store.currentShowItem?.id == rowStore.state.id ? 0 : 1)
          }
        }
      }
      .overlay {
        if let showPageStore = store.scope(state: \.currentShowItem, action: \.showPageAction) {
          detailView(store: showPageStore)
            .edgesIgnoringSafeArea(.top)
//          GameDetailView(store: showPageStore)
        }
      }
      .onAppear {
        store.send(.onAppear)
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

extension FreeToGameView {
  
  @ViewBuilder
  func detailView(store: StoreOf<GameRowReducer>) -> some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        GameRowView(store: store)
        
        VStack(spacing: 15) {
          Divider()
          
          Text(store.game.short_description)
            .multilineTextAlignment(.leading)
            .lineSpacing(10.0)
            .padding(.bottom, 20)
          
          Spacer()
          
          Button {
            
          } label: {
            Label {
              Text("Share Game")
            } icon: {
              Image(systemSymbol: .squareAndArrowUpFill)
            }
            .foregroundColor(.primary)
            .padding(.vertical, 5)
            .padding(.horizontal, 25)
            .background {
              RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(.ultraThinMaterial)
            }
          }
        }
      }
    }
    .background(Color.black)
    .ignoresSafeArea()
    .overlay(alignment: .topTrailing) {
      Button {
        // close
        store.send(.close, animation: .interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7))
      } label: {
        Image(systemSymbol: .xmarkCircleFill)
          .font(.title)
          .foregroundColor(.white)
      }
      .padding([.top], safeArea().top)
      .padding(.trailing)
    }
    .matchedGeometryEffect(id: store.state.id, in: animation)
    .onAppear() {
      store.send(.show, animation: .interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7))
    }
    .transition(.identity)
  }
}

#Preview {
  FreeToGameView(
    store: Store(initialState: FreeToGameReducer.State(games: [])) {
      FreeToGameReducer()
    }
  )
}
