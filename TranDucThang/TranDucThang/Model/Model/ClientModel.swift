//
//  ClientModel.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 22/10/2023.
//

import Foundation

class ClientModel {
    var id: String = ""
    var fullName: String = "" // ho va ten
    var addDress: String = "" // dia chi
    var note: String = "" // ghi chu
    var isWorker: Bool = false
    var phoneNumber: [String] = []
    var listProduct: [ProductModel] = []
    
    init() {}
    
    init(id: String, fullName: String, addDress: String, note: String, isWorker: Bool, phoneNumber: [String], listProduct: [ProductModel]) {
        self.id = id
        self.fullName = fullName
        self.addDress = addDress
        self.note = note
        self.isWorker = isWorker
        self.phoneNumber = phoneNumber
        self.listProduct = listProduct
    }
}
