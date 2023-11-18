//
//  CalendarView.swift
//  Apollo11
//
//  Created by Jarvis on 2023/6/1.
//

import SwiftUI
import Foundation
import Neumorphic
//import ElegantCalendar

public struct CalendarView: View {
  
//  @ObservedObject var calendarManager = ElegantCalendarManager(
//    configuration: CalendarConfiguration(
//      startDate: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36))),
//      endDate: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))
//    )
//  )
  
  public var body: some View {
//    ElegantCalendarView(calendarManager: calendarManager)
    ZStack {
      Color.white
      RoundedRectangle(cornerRadius: 20)
        .fill(Color.Neumorphic.main)
        .frame(width: 120, height: 120)
        .softOuterShadow()
      Text("CalendarView")
    }
  }
  
  public init() {}
}
