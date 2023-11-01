//
//  CustomProductModel.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 21/10/2023.
//

import Foundation
import RealmSwift

class RDetailProduct: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    dynamic var elementProduct: List<RElementProduct> = List()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RDetailProduct {
//    convenience init(uiModel: DetailProduct) {
//        self.init()
//        self.name = uiModel.name
//        self.elementProduct = uiModel.elementProduct
//    }
    
    func toUIModel() -> DetailProduct {
        return DetailProduct(realmID: self.id,
                             name: self.name,
                             elementProduct: [])
    }
}
