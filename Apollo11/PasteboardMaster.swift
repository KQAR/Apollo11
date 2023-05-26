//
//  PasteboardMaster.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import UIKit
import Foundation
import MobileCoreServices
import UniformTypeIdentifiers
import ComposableArchitecture

protocol PasteSecurable {
  func recentlyPasteboardItem() -> PasteboardItem?
}

enum PasteboardItem: Equatable {
  case url(URL)
  case text(String)
  case image(UIImage)
}

class PasteboardMaster: PasteSecurable {
  
  static let shared = PasteboardMaster()
  
  private init() {}
  
  private var pastedBoard: String = ""
  
  private func update() {
    if let pastedBoard = UIPasteboard.general.string {
      self.pastedBoard = pastedBoard
    } else {
      print("no string")
    }
  }
  
  private func pollPasteboardItems() {
  }
  
  private func pasteboardItem(of item: Any?) -> PasteboardItem? {
    if let text = item as? String {
      return .text(text)
    }
    if let image = item as? UIImage {
      return .image(image)
    }
    fatalError("unsupported type")
  }
  
  public func recentlyPasteboardItem() -> PasteboardItem? {
    let pasteboard = UIPasteboard.general
    printLog(pasteboard.types)
    for item in pasteboard.strings ?? [] {
      printLog("\n key:\n \(item)")
      return pasteboardItem(of: item)
    }
    for item in pasteboard.images ?? [] {
      printLog("\n image:\n \(item)")
      return pasteboardItem(of: item)
    }
    return nil
  }
}

// MARK: - Dependency Inject

extension PasteboardMaster: DependencyKey {
  static var liveValue = PasteboardMaster.shared
}

extension DependencyValues {
  var pasteboardMaster: PasteboardMaster {
     get { self[PasteboardMaster.self] }
     set { self[PasteboardMaster.self] = newValue }
   }
}
