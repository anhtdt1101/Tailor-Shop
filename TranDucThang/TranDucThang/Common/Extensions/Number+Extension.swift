//
//  Number+Extension.swift
//  TranDucThang
//
//  Created by Tran Duc Tien Anh on 08/05/2023.
//

import Foundation

extension Double {
    func toCurrecyFormat() -> String? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 0
        let numberAsString = formatter.string(from: NSNumber(value: self ))
        return numberAsString
    }

    func priceString() -> String {
        var result = ""
        let price = self.description
        if price.contains(".") {
            let array = price.components(separatedBy: ".")
            if array.count == 2 {
                if array[1] == "0" {
                    result = array[0]
                } else {
                    result = price
                }
            } else {
                if array.first != nil {
                    result = array.first!
                }
            }
        } else {
            result = price
        }
        return result
    }
    
    func toString() -> String {
        return toString(fraction: 0)
    }
    
    func toString(fraction: Int) -> String {
        return String(format: "%.\(fraction)f", self)
    }
    
    func toDistanceKm() -> String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.roundingMode = .halfUp
        if (self < 1000.0) {
            formatter.maximumFractionDigits = 0
            let stringInMet = formatter.string(from: NSNumber(value: self))
            return stringInMet! + " m"
        } else {
            formatter.maximumFractionDigits = 1
            let stringInKm = formatter.string(from: NSNumber(value: self/1000.0))
            return stringInKm! + " km"
        }
    }
    
    func toHour() -> String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .halfUp
        let hours = self / 3600
        if Int(hours) == 0 {
            let minutes = (self.truncatingRemainder(dividingBy: 3600)) / 60
            formatter.maximumFractionDigits = 0
            if Int(minutes) == 1 {
                return formatter.string(from: NSNumber(value: minutes))! + " Minute"
            } else {
                return formatter.string(from: NSNumber(value: minutes))! + " Minutes"
            }
        } else if Int(hours) == 1 {
            return formatter.string(from: NSNumber(value: hours))! + " Hour"
        } else {
            return formatter.string(from: NSNumber(value: hours))! + " Hours"
        }
    }
    
    func suggestionMoney() -> [Double] {
        let max: Double = 20000000
        let min: Double = 10000
        let powArray: [Double] = [10, 100, 1000, 10000, 100000, 1000000, 10000000]
        var results: [Double] = []
        for item in powArray {
            let value = self*item
            if value >= min && value <= max {
                results.append(value)
            }
        }
        return results
    }
}

extension Decimal {
    var double: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}

extension Int {
    var boolValue: Bool { return self != 0 }
}

extension Bool {
    var string: String {
        return self ? "1" : "0"
    }
    var int: Int {
        return self ? 1 : 0
    }
}
