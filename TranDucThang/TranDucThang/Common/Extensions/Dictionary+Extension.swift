//
//  ExDict.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 26/05/2022.
//

import Foundation
extension Dictionary {
    mutating func merge(dict: [Key: Value]) {
        for (key, value) in dict {
            updateValue(value, forKey: key)
        }
    }
    var notEmpty:Bool {
        return self.count > 0
    }
}
