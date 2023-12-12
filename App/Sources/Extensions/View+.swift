//
//  File.swift
//  
//
//  Created by 金瑞 on 2023/12/9.
//

import SwiftUI

public extension View {
  func safeArea() -> UIEdgeInsets {
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
      return .zero
    }

    guard let safeArea = screen.windows.first?.safeAreaInsets else {
      return .zero
    }

    return safeArea
  }
}
