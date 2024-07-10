//
//  BookListView.swift
//
//
//  Created by 金瑞 on 2024/3/31.
//

import SwiftUI
import SwiftData
import Foundation

public struct BookListView: View {
  
  @Query(sort: \Book.title) private var books: [Book]
  @State private var createNewBook = false
  
  public var body: some View {
    NavigationStack {
      List {
        ForEach(books) { book in
          NavigationLink {
            Text(book.title)
          } label: {
            
          }
        }
      }
      .navigationTitle(Text("My Book", bundle: .module))
      .toolbar {
        Button {
          
        } label: {
          VStack {
            Image(systemName: "plus.circle.fill")
              .imageScale(.large)
            Text("more", bundle: .module)
          }
        }
      }
      .sheet(isPresented: $createNewBook, content: {
        NewBookView()
          .presentationDetents([.medium])
      })
    }
  }
  
  public init() {}
}

#Preview {
  BookListView()
    .environment(\.locale, Locale(identifier: "en"))
    .modelContainer(for: Book.self, inMemory: true)
    .previewDevice("iPhone 12")
}

#Preview {
  BookListView()
    .environment(\.locale, Locale(identifier: "zh-Hans"))
    .modelContainer(for: Book.self, inMemory: true)
    .previewDevice("iPhone 15 Pro")
}
