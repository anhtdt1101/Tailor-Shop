//
//  ElementProduct.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 22/10/2023.
//

import Foundation

class ElementProduct {
    var realmID: String = ""
    var name: String = ""
    var type: InputTypeValue = .string
    
    init() {}
    
    init(realmID: String = "", name: String, type: Int) {
        self.realmID = realmID
        self.name = name
        self.type = .init(rawValue: type) ?? .string
    }
}

enum InputTypeValue: Int {
    case number = 0 // số double
    case price = 1 // tiền sẽ có cách nhau bằng dấu `.`
    case date = 2 // popup chọn ngày
    case string = 3 // textfield mặc định
    case note = 4 // textView
    
    // func ID -> InputTypeValue
    // func InputTypeValue -> ID
}
