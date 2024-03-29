//
//  Date+toString.swift
//  Apollo11
//
//  Created by Jarvis on 2023/6/1.
//

import Foundation

public extension Date {

    var timeOnlyWithPadding: String {
        Formatter.timeOnlyWithPadding.string(from: self)
    }

    var fullMonthWithYear: String {
        Formatter.fullMonthWithYear.string(from: self)
    }

    var abbreviatedDayOfWeek: String {
        Formatter.abbreviatedDayOfWeek.string(from: self)
    }

    var dayOfMonth: String {
        Formatter.dayOfMonth.string(from: self)
    }

}

public extension Formatter {

    static let timeOnlyWithPadding: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    static let fullMonthWithYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM y"
        return formatter
    }()

    static let abbreviatedDayOfWeek: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()

    static let dayOfMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()

}
