//
//  SentencePandect.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import Foundation
import ComposableArchitecture

struct SentencePandect: ReducerProtocol {
  
  @Dependency(\.pasteboardMaster) var pasteboardMaster
  
  struct State: Equatable {
    enum Destination: Hashable {
      case child(SentenceRow.State)
    }
    var title = "Sentences"
    var path: [Destination] = []
    var sentences: IdentifiedArrayOf<SentenceRow.State>
    var alert: AlertState<Action>?
    var confirmationDialog: ConfirmationDialogState<Action>?
    var popupViewIsShowing: Bool = true
    var popupViewState = PopupReducer.State()
  }
  
  enum Action: Equatable {
    case navigationPathChanged([State.Destination])
    case pasteboardCheck
    case alertShowing(PasteboardItem)
    case alertDismissed
    case popupStateChanged(Bool)
    case paste
  }
  
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .navigationPathChanged(path):
        state.path = path
        return .none
      case .pasteboardCheck:
        guard let pasteboardItem = pasteboardMaster.recentlyPasteboardItem() else {
          return .none
        }
        return .send(.alertShowing(pasteboardItem))
      case .alertDismissed:
        state.alert = nil
        return .none
      case let .alertShowing(item):
        state.popupViewState = popupState(with: item)
        state.alert = alertState(with: item)
        return .none
      case let .popupStateChanged(showing):
        state.popupViewIsShowing = showing
        return .none
      case .paste:
        print("paste...")
        
        return .none
      }
    }
  }
  
  private func popupState(with item: PasteboardItem) -> PopupReducer.State {
    switch item {
    case .url(let url):
      return PopupReducer.State()
    case .text(let text):
      return PopupReducer.State(text: text)
    case .image(let image):
      return PopupReducer.State(image: image)
    }
  }
  
  private func alertState(with item: PasteboardItem) -> AlertState<Action> {
    return AlertState {
      TextState("Alert!")
    } actions: {
      ButtonState(role: .cancel) {
        TextState("Cancel")
      }
      ButtonState(action: .paste) {
        TextState("Paste")
      }
    } message: {
        switch item {
        case let .text(text):
          print("===== text ==> \(text)")
          return TextState(text)
        case let .image(image):
          print("===== image => \(image)")
          return TextState("this is a image")
        case let .url(url):
          print(url)
          return TextState("this is a URL")
        }
    }
  }
}
