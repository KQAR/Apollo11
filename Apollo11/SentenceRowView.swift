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
    WithViewStore(store) { viewStore in
//      HStack {
//        Text(viewStore.sentence)
//          .fontWeight(.medium)
//        Spacer()
//      }
//      .padding(15)
//      .background(Color.yellow)
      HStack {
        RoundedRectangle(cornerRadius: 16)
          .fill(viewStore.tagColor)
          .frame(width: 5, height: 30)
        
        VStack(alignment: .leading) {
          Text(viewStore.sentence)
            .font(.system(size: 16))
            .lineLimit(1)
          Text(viewStore.timeString)
            .font(.system(size: 10))
            .lineLimit(1)
        }
        
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
      store: Store(
        initialState: .mock,
        reducer: SentenceRow()
      )
    )
  }
}
