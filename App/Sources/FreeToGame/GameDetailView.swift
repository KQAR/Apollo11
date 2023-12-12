//
//  GameDetailView.swift
//
//
//  Created by 金瑞 on 2023/12/9.
//

import SwiftUI
import ComposableArchitecture
import Extensions

struct GameDetailView: View {
  
  let store: StoreOf<GameRowReducer>
  
  var body: some View {
    WithPerceptionTracking {
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
      .onAppear() {
        store.send(.show, animation: .interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7))
      }
      .transition(.identity)
    }
  }
}

#Preview {
  GameDetailView(
    store: Store(initialState: GameRowReducer.State(id: UUID(), game: .mock)) {
      GameRowReducer()
    }
  )
}
