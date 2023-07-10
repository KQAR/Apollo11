//
//  Apollo11App.swift
//  Apollo11
//
//  Created by Jarvis on 2023/4/28.
//

import SwiftUI
import App
import Debug
import ComposableArchitecture

@main
struct Apollo11App: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      AppView(store: Store(initialState: .init(), reducer: AppReducer()))
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
  func applicationDidBecomeActive(_ application: UIApplication) {
    printLog("应用程序进入前台")
  }
}
