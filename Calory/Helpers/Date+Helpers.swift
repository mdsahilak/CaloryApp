//
//  Date+Helpers.swift
//  Calory
//
//  Created by Sahil Ak on 14/05/24.
//

import Foundation

extension Date {
    var isCurrentDay: Bool { Calendar.current.isDateInToday(self) }
    var shortDayName: String {
        guard !isCurrentDay else { return "Today" }
        
        let formatter = DateFormatter()
        return formatter.shortWeekdaySymbols[Calendar.current.component(.weekday, from: self) - 1]
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!.addingTimeInterval(-1)
    }
    
    /// Get the same Date Object, but in the previous day. (Pass in count to choose how many days back you want to go to.)
    func equivalentDateOfPreviousDay(count: Int = -1) -> Date {
        Calendar.current.date(byAdding: .day, value: count, to: self)!
    }
}
