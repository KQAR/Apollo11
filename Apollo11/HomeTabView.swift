//
//  HomeTabView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/4/28.
//

import SwiftUI

struct HomeTabView: View {
  @State private var selection = 0
  var body: some View {
    ZStack {
      TabView(selection: $selection) {
        SentencePandectView()
          .tag(0)
          .tabItem {
            Text("句子")
          }
        SettingView()
          .tag(1)
          .tabItem {
            Text("设置")
          }
      }
    }
  }
}

struct HomeTabView_Previews: PreviewProvider {
  static var previews: some View {
    HomeTabView()
  }
}
