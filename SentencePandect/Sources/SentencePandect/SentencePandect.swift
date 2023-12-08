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
import Popup

@Reducer
public struct SentencePandect {
  
  @Dependency(\.pasteboardMaster) var pasteboardMaster
  
  public struct State: Equatable {
    public enum Destination: Hashable {
      case child(SentenceRow.State)
    }
    
    var title = "Sentences"
    var path: [Destination] = []
    var sentences: IdentifiedArrayOf<SentenceRow.State>
    var popupViewIsShowing: Bool = false
    var popupViewState = PopupReducer.State()
    
    @PresentationState var alert: AlertState<Action.Alert>?
  }
  
  public enum Action {
    public enum Alert {
      case paste
    }
    
    case navigationPathChanged([State.Destination])
    case pasteboardCheck
    case ocrScan(UIImage)
    case alertShowing(String)
    case alert(PresentationAction<Alert>)
    case popupViewHidden(Bool)
    case popupViewShow(UIImage, String)
    case paste
    case popupAction(PopupReducer.Action)
    case sentenceRow(IdentifiedActionOf<SentenceRow>)
    case delete(IndexSet)
    case move(IndexSet, Int)
  }
  
  public var body: some Reducer<State, Action> {
    Scope(state: \.popupViewState, action: \.popupAction) {
      PopupReducer()
    }
    .forEach(\.sentences, action: \.sentenceRow) {
      SentenceRow()
    }
    Reduce { state, action in
      switch action {
      case .popupAction:
        return .none
      case let .delete(indexSet):
        let removeIds = indexSet.map { state.sentences[$0].id }
        for id in removeIds {
          state.sentences.remove(id: id)
        }
        return .none
      case let .move(source, destination):
        state.sentences.move(fromOffsets: source, toOffset: destination)
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
      case .alert(.presented(.paste)):
        printLog("paste~~~")
        state.alert = nil
        return .none
      case .alert:
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
      case let .sentenceRow(row):
        if case let .element(id, action) = row {
          printLog("sentenceRow: id: \(id) action: \(action)")
        }
        return .none
      }
    }
  }
  
  public init() {}
  
  private func alertState(with text: String) -> AlertState<Action.Alert> {
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
