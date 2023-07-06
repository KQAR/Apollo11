import UIKit
import Foundation
import MobileCoreServices
import UniformTypeIdentifiers
import ComposableArchitecture
import Debug

public protocol PasteSecurable {
  func recentlyPasteboardItem() -> PasteboardItem?
}

public enum PasteboardItem: Equatable {
  case url(URL)
  case text(String)
  case image(UIImage)
}

public class PasteboardMaster: PasteSecurable {
  
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
  
  public func copyToClipboard(text: String) {
    let pastedBoard = UIPasteboard.general
    pastedBoard.string = text
  }
}

// MARK: - Dependency Inject

extension PasteboardMaster: DependencyKey {
  public static var liveValue = PasteboardMaster.shared
}

public extension DependencyValues {
  var pasteboardMaster: PasteboardMaster {
     get { self[PasteboardMaster.self] }
     set { self[PasteboardMaster.self] = newValue }
   }
}
