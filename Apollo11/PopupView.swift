//
//  PopupView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/26.
//

import SwiftUI
import PopupView
import ComposableArchitecture

struct PopupReducer: ReducerProtocol {
  
  struct State: Equatable {
    var title: String?
    var text: String?
    var image: UIImage?
  }
  
  enum Action {
    
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      return .none
    }
  }
}

struct PopupView: View {
  
  let store: StoreOf<PopupReducer>
  
  @State var flipped = false
  @State var gradietnModel = AnimatedGradient.Model(colors: [])
  
  var body: some View {
    WithViewStore(store) { viewStore in
      ZStack {
        if flipped == false {
            VStack(alignment: .center, spacing: 8) {
              Spacer()
              
              Text("发现剪切板有图片")
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
                self.flipped.toggle()
              } label: {
                Text("Accept".uppercased())
                  .font(.system(size: 14, weight: .black))
              }
              .buttonStyle(.borderedProminent)
              
              Spacer()
            }
        } else {
            VStack(alignment: .center, spacing: 8) {
              Text("In the above example, your_image_name represents the name of the image you want to display. By applying the .resizable() modifier, you allow the image to be resized based on the available space. The .aspectRatio(contentMode: .fit) modifier sets the content mode to fit the aspect ratio of the image within its allocated frame. The .clipped() modifier ensures that the image is clipped to its frame if it exceeds the available space.")
              Text("You can adjust the contentMode parameter of the .aspectRatio(contentMode:) modifier to achieve different image scaling and positioning behaviors. Here are the available content modes:")
            }
            .padding(16)
            .rotation3DEffect(.degrees( -180.0), axis: (x: 0.0, y: 1.0, z: 0.0))
        }
      }
      .background(GradientEffectView($gradietnModel))
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .frame(height: self.flipped ? 400 : 98)
      .padding(.horizontal, 16)
      .rotation3DEffect(Angle(degrees: self.flipped ? 180 : 0), axis: (x: 0, y: 1, z:0))
      .animation(.spring(dampingFraction: 0.9), value: self.flipped)
      .onTapGesture {
        self.flipped.toggle()
      }
      .onAppear {
        updateColors(with: viewStore.image)
      }
    }
  }
  
}

import ColorKit
extension PopupView {
  func updateColors(with image: UIImage?) {
    guard let dominantColors = try? image?.dominantColorFrequencies(with: .high) else { return }
    let colors = dominantColors
      .prefix(5)
      .enumerated()
      .map { ($0.offset, $0.element.color, $0.element.frequency) }
    
    withAnimation(.linear.speed(0.2)) {
      gradietnModel.colors = colors.map { Color(uiColor: $0.1) }
    }
  }
}
