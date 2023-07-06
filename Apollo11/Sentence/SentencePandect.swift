//
//  SentencePandect.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import UIKit
import Foundation
import ComposableArchitecture
import Pasteboard
import Debug
import OCR

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
    var popupViewIsShowing: Bool = false
    var popupViewState = PopupReducer.State()
  }
  
  enum Action: Equatable {
    case update(IdentifiedArrayOf<SentenceRow.State>)
    case navigationPathChanged([State.Destination])
    case pasteboardCheck
    case ocrScan(UIImage)
    case alertShowing(String)
    case alertDismissed
    case popupViewHidden(Bool)
    case popupViewShow(UIImage, String)
    case paste
    case popupAction(PopupReducer.Action)
  }
  
  var body: some ReducerProtocol<State, Action> {
    Scope(state: \.popupViewState, action: /Action.popupAction) {
      PopupReducer()
    }
    Reduce { state, action in
      switch action {
      case .popupAction:
        return .none
      case .update(let sentences):
        state.sentences = sentences
        return .none
      case let .navigationPathChanged(path):
        state.path = path
        return .none
      case .pasteboardCheck:
        guard let pasteboardItem = pasteboardMaster.recentlyPasteboardItem() else {
          return .none
        }
        switch pasteboardItem {
        case .url(_):
          return .none
        case .text(let text):
          return .send(.alertShowing(text))
        case .image(let image):
          return .send(.ocrScan(image))
        }
      case let .ocrScan(image):
        return .run { send in
//          let text = try await OCR.scanText(from: image)
          let text = try await OCR.vision(from: image).transcript
          await send(.popupViewShow(image, text))
        }
      case .alertDismissed:
        state.alert = nil
        return .none
      case let .alertShowing(text):
        state.alert = alertState(with: text)
        return .none
      case let .popupViewHidden(showing):
        state.popupViewIsShowing = showing
        return .none
      case let .popupViewShow(image, text):
        state.popupViewState = PopupReducer.State(title: "发现剪切板有图片", text: text, image: image)
        return .send(.popupViewHidden(true))
      case .paste:
        printLog("paste")
        return .none
      }
    }
  }
  
  private func alertState(with text: String) -> AlertState<Action> {
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
      return TextState(text)
    }
  }
}

extension SentencePandect.State {
  static let mock = Self(
    sentences: IdentifiedArrayOf(uniqueElements: [
      SentenceRow.State(
        id: UUID(),
        tagColor: .cyan,
        sentence: "Learning how to query loaded code is essential for learning how to create breakpoints on that code. ",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .purple,
        sentence: "Both Objective-C and Swift have specific property signatures when they’re created by the compiler, which results in different querying strategies when looking for code.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .cyan,
        sentence: "Learning how to query loaded code is essential for learning how to create breakpoints on that code. ",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .purple,
        sentence: "Both Objective-C and Swift have specific property signatures when they’re created by the compiler, which results in different querying strategies when looking for code.",
        time: Date()
      ),
      SentenceRow.State(
        id: UUID(),
        tagColor: .orange,
        sentence: "You’ll get output similar to the previous command, this time showing the implementation address and of the setter’s declaration for name.",
        time: Date()
      )
    ])
  )
  
}
