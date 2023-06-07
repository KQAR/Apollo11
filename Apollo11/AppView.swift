//
//  AppView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/6/5.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
  
  let store: StoreOf<AppReducer>
  
  var body: some View {
    ZStack {
      WithViewStore(store, observe: \.tab) { viewStore in
        switch viewStore.state {
        case .home:
          SentencePandectView(store: store.scope(state: \.home, action: AppReducer.Action.home))
        case .calendar:
          CalendarView()
        case .setting:
          SettingView()
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .safeAreaInset(edge: .bottom, spacing: 0) { tabBar }
  }
}

extension AppView {
  private var tabBar: some View {
    WithViewStore(store, observe: \.tab) { viewStore in
      HStack {
        ForEach(AppReducer.Tab.allCases, id: \.self) { item in
          VStack(spacing: 6) {
            Image(systemSymbol: item == viewStore.state ? item.selectedIcon : item.icon)
              .frame(width: 26, height: 26)
            Text(item.title)
              .font(.system(size: 10))
          }
          .frame(maxWidth: .infinity, alignment: .center)
          .contentShape(Rectangle())
          .onTapGesture {
            print("ddddd ===> \(item)")
            viewStore.send(.set(\.$tab, item), animation: .linear(duration: 0.15))
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
}

struct  AppView_Previews: PreviewProvider {
  static var previews: some View {
    AppView(store: Store(initialState: .init(), reducer: AppReducer()))
  }
}
