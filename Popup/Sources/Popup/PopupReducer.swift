//
//  PopupReducer.swift
//  
//
//  Created by 金瑞 on 2023/12/8.
//

import SwiftUI
import Foundation
import ComposableArchitecture
import ColorKit
import Debug
import Pasteboard

@Reducer
public struct PopupReducer {
  
  @Dependency(\.pasteboardMaster) var pasteboardMaster
  
  @ObservableState
  public struct State: Equatable {
    var title: String?
    var text: String?
    var image: UIImage?
    var gradientModel = AnimatedGradient.Model(colors: [])
    
    var flipped = false
    
    public init(
      title: String? = nil,
      text: String? = nil,
      image: UIImage? = nil,
      gradientModel: AnimatedGradient.Model = AnimatedGradient.Model(colors: []),
      flipped: Bool = false
    ) {
      self.title = title
      self.text = text
      self.image = image
      self.gradientModel = gradientModel
      self.flipped = flipped
    }
  }
  
  public enum Action: Equatable {
    case flip
    case updateGradient
    case updateGradientModel(AnimatedGradient.Model)
    case copy
  }
  
  public func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .flip:
      state.flipped.toggle()
      printLog("fliped end  ==> \(state.flipped)")
      return .none
    case .updateGradient:
      guard let dominantColors = try? state.image?.dominantColorFrequencies(with: .high) else { return .none }
      let colors = dominantColors
        .prefix(5)
        .enumerated()
        .map { ($0.offset, $0.element.color, $0.element.frequency) }
      
      withAnimation(.linear.speed(0.2)) {
        state.gradientModel.colors = colors.map { Color(uiColor: $0.1) }
      }
      return .none
    case .updateGradientModel(let model):
      state.gradientModel = model
      return .none
    case .copy:
      if let text = state.text {
        pasteboardMaster.copyToClipboard(text: text)
      }
      return .none
    }
  }
  
  public init() {}
}
