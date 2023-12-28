//
//  SettingView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/4/28.
//

import SwiftUI
import Setting
import ColorfulX

public struct SettingView: View {

  @State var colors: [Color] = ColorfulPreset.aurora.colors
  
  public var body: some View {
    ZStack {
      ColorfulView(color: $colors)
        .ignoresSafeArea()
//      SettingStack {
//        SettingPage(title: "Setting") {
//          // Group 1
//          SettingGroup {
//            SettingText(title: "Hello!")
//          }
//          // Group 2
//          SettingGroup {
//            SettingPage(title: "First Page") {}
//              .previewIcon("star")
//            
//            SettingPage(title: "Second Page") {}
//              .previewIcon("sparkles")
//            
//            SettingPage(title: "Third Page") {}
//              .previewIcon("leaf.fill")
//          }
//        }
//      }
    }
  }
  
  public init() {}
}

#Preview {
  SettingView()
}
