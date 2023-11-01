//
//  ProductModel.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 22/10/2023.
//

import Foundation

class ProductModel {
    var realmID: String = ""
    var dateCreated: Date = Date()
    var pickUpDate: String = ""
    var productColor: String = ""
    var price: String = ""
    var deposit: String = ""
    var note: String = ""
    var status: StatusProduct = .notYet
    var detailProduct = DetailProduct()
  
    init() {}
    
    init(realmID: String, dateCreated: Date, pickUpDate: String, productColor: String, price: String, deposit: String, note: String, status: StatusProduct, detailProduct: DetailProduct = DetailProduct()) {
        self.realmID = realmID
        self.dateCreated = dateCreated
        self.pickUpDate = pickUpDate
        self.productColor = productColor
        self.price = price
        self.deposit = deposit
        self.note = note
        self.status = status
        self.detailProduct = detailProduct
    }
    
}

enum StatusProduct: Int {
    case done = 0 // đã trả tiền
    case created = 1 // đã làm xong nhưng chưa lấy hàng
    case notYet = 2 // chưa làm
    case cancle = 3// huỷ
}
