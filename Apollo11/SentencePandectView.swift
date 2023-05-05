//
//  SentencePandectView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/4/28.
//

import SwiftUI

struct SentencePandectView: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(1...100, id: \.self) { i in
          SentenceRow()
        }
      }
      .frame(width: .infinity, height: .infinity, alignment: .leading)
    }
  }
}

struct SentencePandectView_Previews: PreviewProvider {
  static var previews: some View {
    SentencePandectView()
  }
}
