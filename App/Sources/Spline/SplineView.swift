//
//  SplineView.swift
//
//
//  Created by Jarvis on 2024/1/9.
//

import SwiftUI

public struct SplineDemoView: View {

  @AppStorage("splineName", store: UserDefaults(suiteName: "group.78X6FL4YJY.com.person.apollo11.mygroup"))
  var splineName: String = "scene spline"

  public var body: some View {
    VStack {
      Text(splineName)
      TextField("输入 Spline Name", text: $splineName)
    }
  }

  public init() {}
}
