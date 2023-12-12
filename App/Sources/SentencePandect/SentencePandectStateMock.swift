//
//  SentencePandectStateMock.swift
//
//
//  Created by 金瑞 on 2023/12/8.
//

import Foundation
import ComposableArchitecture

public extension SentencePandect.State {
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

extension SentenceRow.State {
  static var mock: Self {
    return Self(id: UUID(), tagColor: .blue, sentence: "Hello World", time: Date())
  }
}
