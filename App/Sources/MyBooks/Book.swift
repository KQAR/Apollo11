//
//  Book.swift
//  
//
//  Created by 金瑞 on 2024/3/16.
//

import Foundation
import SwiftData

@Model
public class Book {
  var title: String
  var author: String
  var dateAdded: Date
  var dateStarted: Date
  var dateCompleted: Date
  var summart: String
  var rating: Int?
  var status: Status
  
  init(
    title: String,
    author: String,
    dateAdded: Date = Date.now,
    dateStarted: Date = Date.distantPast,
    dateCompleted: Date = Date.distantPast,
    summart: String = "",
    rating: Int? = nil,
    status: Status = .onShelf
  ) {
    self.title = title
    self.author = author
    self.dateAdded = dateAdded
    self.dateStarted = dateStarted
    self.dateCompleted = dateCompleted
    self.summart = summart
    self.rating = rating
    self.status = status
  }
}

public enum Status: Int, Codable, Identifiable, CaseIterable {
  case onShelf, inProgress, completed
  
  public var id: Self {
    return self
  }
}
