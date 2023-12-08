//
//  PopupView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/26.
//

import SwiftUI
import ComposableArchitecture
import ColorKit
import Debug
import Pasteboard

@Reducer
public struct PopupReducer {
  
  @Dependency(\.pasteboardMaster) var pasteboardMaster
  
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

public struct PopupView: View {
  
  let store: StoreOf<PopupReducer>
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        if viewStore.flipped == false {
          VStack(alignment: .center, spacing: 8) {
            Spacer()
            
            Text(viewStore.title ?? "")
              .bold()
              .foregroundColor(.black)
            
            Image(uiImage: viewStore.image ?? UIImage())
              .resizable()
              .scaledToFit()
              .frame(width: 200, height: 200, alignment: .center)
              .cornerRadius(8)
              .padding(15.0)
            
            Button {
              debugPrint("Accepted!")
              viewStore.send(.flip)
            } label: {
              Text("Accept".uppercased())
                .font(.system(size: 14, weight: .black))
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
          }
        } else {
          VStack(alignment: .center, spacing: 8) {
            Text(viewStore.text ?? "")
            Button {
              viewStore.send(.copy)
            } label: {
              Text("copy".uppercased())
                .font(.system(size: 14, weight: .black))
            }
            .buttonStyle(.borderedProminent)
          }
          .padding(16)
          .rotation3DEffect(.degrees( -180.0), axis: (x: 0.0, y: 1.0, z: 0.0))
        }
      }
      .background(GradientEffectView(viewStore.binding(get: \.gradientModel, send: PopupReducer.Action.updateGradientModel)))
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .frame(height: viewStore.flipped ? 400 : 98)
      .padding(.horizontal, 16)
      .rotation3DEffect(Angle(degrees: viewStore.flipped ? 180 : 0), axis: (x: 0, y: 1, z:0))
      .animation(.spring(dampingFraction: 0.9), value: viewStore.flipped)
      .onTapGesture {
        viewStore.send(.flip)
      }
      .onAppear {
        viewStore.send(.updateGradient)
      }
    }
  }
  
  public init(store: StoreOf<PopupReducer>) {
    self.store = store
  }
}
