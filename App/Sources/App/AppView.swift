//
//  AppView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/6/5.
//

import SwiftUI
import ComposableArchitecture
import Profile
import Calendar
import SentencePandect
import ViewComponents
import FreeToGame
import Spline

public struct AppView: View {
  
  @BindableStore var store: StoreOf<AppReducer>
  
  public var body: some View {
    ZStack {
      WithPerceptionTracking {
        switch store.tab {
        case .home:
          SentencePandectView(store: store.scope(state: \.home, action: \.home))
        case .calendar:
          FreeToGameView(store: store.scope(state: \.freeGames, action: \.freeGames))
        case .setting:
//          CalendarView()
          SplineDemoView()
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .safeAreaInset(edge: .bottom, spacing: 0) { tabBar }
  }
  
  public init(store: StoreOf<AppReducer>) {
    self.store = store
  }
}

extension AppView {
  private var tabBar: some View {
    HStack {
      ForEach(AppReducer.Tab.allCases, id: \.self) { item in
        VStack(spacing: 6) {
          Image(systemSymbol: item == store.tab ? item.selectedIcon : item.icon)
            .frame(width: 26, height: 26)
          Text(item.title)
            .font(.system(size: 10))
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .contentShape(Rectangle())
        .onTapGesture {
          store.send(.set(\.tab, item), animation: .linear(duration: 0.15))
        }
      }
      .padding([.horizontal, .top, .bottom], 12)
    }
    .frame(maxWidth: .infinity)
    .background(
      BlurView(.systemThinMaterial)
        .edgesIgnoringSafeArea(.bottom)
    )
  }
}

struct AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView(
      store: Store(initialState: .init()) {
        AppReducer()
      }
    )
  }
}
