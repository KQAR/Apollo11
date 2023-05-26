//
//  PopupView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/26.
//

import SwiftUI
import PopupView
import ComposableArchitecture

struct PopupState<Action>: Identifiable {
  let id: UUID
  var title: String?
  var text: String?
  var image: String?
}

extension PopupState: Equatable where Action: Equatable {
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.title == rhs.title
      && lhs.text == rhs.text
      && lhs.image == rhs.image
  }
}

extension PopupState: Hashable where Action: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.title)
    hasher.combine(self.text)
    hasher.combine(self.image)
  }
}

//extension View {
//  @ViewBuilder func popup<Action>(
//    _ store: Store<PopupState<Action>?, Action>,
//    dismiss: Action
//  ) -> some View {
//    
//  }
//}

//private struct PopupViewModifier<Action>: ViewModifier {
//  @StateObject var viewStore: ViewStore<PopupState<Action>?, Action>
//  let dismiss: Action
//
//  func body(content: Content) -> some View {
////    content.alert(
////      (viewStore.state?.title).map { Text($0) } ?? Text(""),
////      isPresented: viewStore.binding(send: dismiss).isPresent(),
////      presenting: viewStore.state,
////      actions: {
////        ForEach($0.buttons) {
////          Button($0) { action in
////            if let action = action {
////              viewStore.send(action)
////            }
////          }
////        }
////      },
////      message: { $0.message.map { Text($0) } }
////    )
//    content.popup(
//      isPresented: <#T##Binding<Bool>#>, view: <#T##() -> View#>, customize: <#T##(Popup<View>.PopupParameters) -> Popup<View>.PopupParameters#>)
//  }
//}
