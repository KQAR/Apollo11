//
//  HomeTabView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/4/28.
//

import SwiftUI
import ComposableArchitecture
import SFSafeSymbols

struct HomeTabView: View {
  @State private var selection = 0
  var body: some View {
    TabView(selection: $selection) {
      SentencePandectView(
        store: Store(
          initialState: SentencePandect.State(sentences: sentences),
          reducer: SentencePandect()
        )
      )
      .tag(0)
      .tabItem {
        Image(systemSymbol: .textWordSpacing)
      }
      SettingView()
        .tag(1)
        .tabItem {
          Image(systemSymbol: .gear)
        }
    }
  }
}

struct HomeTabView_Previews: PreviewProvider {
  static var previews: some View {
    HomeTabView()
  }
}
