//
//  Date+Extension.swift
//  VVBASE
//
//  Created by Tran Duc Tien Anh on 08/05/2023.
//

import Foundation

extension Date {
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
    
    func numberDaysBetweenDate(_ date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
}
