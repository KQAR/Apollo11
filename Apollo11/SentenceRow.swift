//
//  SentenceRow.swift
//  Apollo11
//
//  Created by Jarvis on 2023/5/5.
//

import SwiftUI

struct SentenceRow: View {
    var body: some View {
      HStack {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Spacer()
      }.padding(15)
    }
}

struct SentenceRow_Previews: PreviewProvider {
    static var previews: some View {
        SentenceRow()
    }
}
