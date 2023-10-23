//
//  ProductModel.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 21/10/2023.
//

import Foundation
import RealmSwift

class RProductModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var dateCreated: Date = Date()
    @objc dynamic var pickUpDate: String = ""
    @objc dynamic var productColor: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var deposit: String = ""
    @objc dynamic var note: String = ""
    @objc dynamic var status: Int = 0
    @objc dynamic var detailProduct: RDetailProduct?
 
    override class func primaryKey() -> String? {
        return "id"
    }
}
