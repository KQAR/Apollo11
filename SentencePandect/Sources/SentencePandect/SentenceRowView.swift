//
//  SentenceRowView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import SwiftUI
import ComposableArchitecture

struct SentenceRowView: View {
  
  let store: StoreOf<SentenceRow>
  
  var body: some View {
    WithPerceptionTracking {
      HStack {
        RoundedRectangle(cornerRadius: 16)
          .fill(store.tagColor)
          .frame(width: 5, height: 30)
        
        VStack(alignment: .leading) {
          Text(store.sentence)
            .font(.system(size: 16))
            .lineLimit(1)
          Text(store.timeString)
            .font(.system(size: 10))
            .lineLimit(1)
        }
        
        // To-do: Something Crash in this code
//        Button(action: {
//          viewStore.send(.delete)
//        }) {
//          Image(systemName: "trash")
//            .foregroundColor(.gray)
//        }
        
        Spacer()
      }
      .frame(height: 30)
      .padding(.vertical, 5)
    }
  }
}

struct SentenceRow_Previews: PreviewProvider {
  static var previews: some View {
    SentenceRowView(
      store: Store(initialState: .mock) {
        SentenceRow()
      }
    )
  }
}
