//
//  GameRowView.swift
//
//
//  Created by 金瑞 on 2023/12/9.
//

import SwiftUI
import Kingfisher
import ComposableArchitecture

struct GameRowView: View {
  
  let store: StoreOf<GameRowReducer>
  let animation: Namespace.ID
  let isSource: Bool
  
  var body: some View {
    WithPerceptionTracking {
      VStack(alignment: .leading, spacing: 0) {
        header
        content
      }
      .matchedGeometryEffect(id: store.state.id, in: animation, isSource: isSource)
    }
  }
  
  var header: some View {
    ZStack() {
      GeometryReader { proxy in
        let size = proxy.size
        
        KFImage(URL(string: store.game.thumbnail))
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: size.width, height: size.height)
          .clipped()
        
        VStack(alignment: .leading, spacing: 4) {
          Spacer()
          Text(store.game.platform)
            .font(.callout.bold())
          
          Text(store.game.title)
            .font(.title.bold())
          
          Text(store.game.short_description)
            .font(.title3.bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(LinearGradient(colors: [Color.clear, Color.black.opacity(0.8)], startPoint: .top, endPoint: .bottom))
      }
    }
    .frame(height: 400)
    .clipShape(.rect(topLeadingRadius: 20, topTrailingRadius: 20))
  }
  
  var content: some View {
    HStack() {
      KFImage(URL(string: store.game.thumbnail))
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 60, height: 60)
        .clipShape(.rect(cornerRadius: 15))
   
      VStack(alignment: .leading, spacing: 4) {
        Text(store.game.platform)
          .font(.caption.bold())
        Text(store.game.title)
          .font(.title3.bold())
        Text(store.game.developer)
          .font(.caption.bold())
      }
      .padding(.vertical)
      
      Spacer()
      
      Button {
        
      } label: {
        Text("GET")
          .fontWeight(.bold)
          .foregroundStyle(.blue)
          .padding(.vertical, 8)
          .padding(.horizontal, 20)
          .background {
            Capsule().fill(.ultraThinMaterial)
          }
      }
    }
    .frame(height: 60)
    .padding()
    .background(Color.cyan)
    .clipShape(.rect(bottomLeadingRadius: store.isAnimationView ? 0 : 20, bottomTrailingRadius: store.isAnimationView ? 0 : 20))
  }
}

#Preview {
  @Namespace var namespace
  
  return GameRowView(
    store: Store(initialState: GameRowReducer.State(id: UUID(), game: .mock)) {
      GameRowReducer()
    },
    animation: namespace,
    isSource: true
  )
}
