//
//  Array+Extense.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 27/06/2022.
//

import Foundation
extension Array {
    var notEmpty: Bool {
        return self.count > 0
    }
    
    func pick(length: Int) -> [Element]  {
        precondition(length >= 0, "length must not be negative")
        if length >= count { return self }
        let oldMax = Double(count - 1)
        let newMax = Double(length - 1)
        return (0..<length).map { self[Int((Double($0) * oldMax / newMax).rounded())] }
    }
}

extension Array {
    func fillterBy(_ block:((Element)->Bool)) -> [Element] {
        var rslt:[Element] = []
        for el in self {
            if block(el) {
                rslt.append(el)
            }
        }
        return rslt
    }
}

extension Sequence {
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}
