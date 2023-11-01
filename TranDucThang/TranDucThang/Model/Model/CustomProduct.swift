//
//  CustomProduct.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 22/10/2023.
//

import Foundation

class DetailProduct {
    var realmID: String = ""
    var name: String = ""
    var elementProduct: [String] = []
    
    init() {}
    
    init(realmID: String = "", name: String, elementProduct: [String]) {
        self.realmID = realmID
        self.name = name
        self.elementProduct = elementProduct
    }
}


