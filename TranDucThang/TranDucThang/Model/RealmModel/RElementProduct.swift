//
//  ElementProduct.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 21/10/2023.
//

import Foundation
import RealmSwift

class RElementProduct: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var type: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RElementProduct {
//    convenience init(uiModel: ElementProduct) {
//        self.init()
//        self.name = uiModel.name
//        self.elementProduct = uiModel.elementProduct
//    }
    
    func toUIModel() -> ElementProduct {
        return ElementProduct(realmID: self.id,
                              name: self.name,
                              type: self.type)
    }
}
