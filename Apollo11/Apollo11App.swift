//
//  Apollo11App.swift
//  Apollo11
//
//  Created by Jarvis on 2023/4/28.
//

import SwiftUI
import WidgetKit
import App
import Debug
import ComposableArchitecture

@main
struct Apollo11App: App {
  
  @Environment(\.scenePhase) private var scenePhase

  var body: some Scene {
    WindowGroup {
      AppView(
        store: Store(initialState: .init()) {
          AppReducer()
        }
      ).onChange(of: scenePhase) { olaPhase, newPhase in
        switch newPhase {
        case .background:
          printLog("应用程序进入后台", tags: DebugTag(rawValue: "📱"))
          WidgetCenter.shared.reloadAllTimelines()
        case .inactive:
          printLog("应用程序闲置", tags: DebugTag(rawValue: "📱"))
        case .active:
          printLog("应用程序激活", tags: DebugTag(rawValue: "📱"))
        @unknown default:
          break
        }
      }
    }
  }
}
