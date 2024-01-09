//
//  SplineView.swift
//
//
//  Created by Jarvis on 2024/1/9.
//

import SwiftUI
import SplineRuntime

public struct SplineDemoView: View {
  public var body: some View {
    // fetching from cloud
    let url = URL(string: "https://build.spline.design/bggWOjtMNDH0lk5WECYc/scene.splineswift")!

    // // fetching from local
    // let url = Bundle.main.url(forResource: "scene", withExtension: "splineswift")!

    try? SplineView(sceneFileURL: url).ignoresSafeArea(.all)
  }

  public init() {}
}
