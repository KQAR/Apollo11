//
//  SettingView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/4/28.
//

import SwiftUI
import Colorful
import Setting

struct SettingView: View {
  var body: some View {
    ZStack {
      ColorfulView()
      SettingStack {
        SettingPage(title: "Setting") {
          // Group 1
          SettingGroup {
            SettingText(title: "Hello!")
          }
          // Group 2
          SettingGroup {
            SettingPage(title: "First Page") {}
              .previewIcon("star")
            
            SettingPage(title: "Second Page") {}
              .previewIcon("sparkles")
            
            SettingPage(title: "Third Page") {}
              .previewIcon("leaf.fill")
          }
        }
      }
    }
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView()
  }
}
