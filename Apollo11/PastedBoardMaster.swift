//
//  PastedBoardMaster.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import UIKit
import Foundation

class PastedBoardMaster {
  
  static let shared = PastedBoardMaster()
  
  private init() {}
  
  var pastedBoard: String = ""
  
  func update() {
    if let pastedBoard = UIPasteboard.general.string {
      self.pastedBoard = pastedBoard
    } else {
      print("no string")
    }
  }
}

