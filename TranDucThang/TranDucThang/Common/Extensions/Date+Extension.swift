//
//  Date+Extension.swift
//  VVBASE
//
//  Created by Anh Nguyen on 24/05/2022.
//

import Foundation

extension Date {
    var millisecondsSince1970: Int64 {
        return Int64(self.timeIntervalSince1970 * 1000.0)
    }
    
    var secondsSince1970: Int64 {
        return Int64(self.timeIntervalSince1970)
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(Double(milliseconds) / 1000.0))
    }
    
    init(seconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(Double(seconds)))
    }
    
    func stringWithFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter.string(from: self)
    }
    
    static func dateFromString(_ dateString: String, with format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "vi_VN_POSIX")
        return formatter.date(from: dateString)
    }
    
    func compareWithDate(_ date: Date) -> Bool {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let datesAreInTheSameDay = calendar.isDate(self, equalTo: date, toGranularity:.day)
        
        return datesAreInTheSameDay
    }
    
    func numberDaysBetweenDate(_ date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
}
