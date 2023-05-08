//
//  ShirtModel.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 09/08/2022.
//

import Foundation
import RealmSwift

class ShirtModel: ProductModel {
    @objc dynamic var shoulder: String = "" // vai
    @objc dynamic var chest: String = "" // nguc
    @objc dynamic var shirtLength: String = "" // chieu dai ao
    @objc dynamic var sleeveLenght: String = "" // chieu dai tay ao
    @objc dynamic var necklace: String = "" // co
    @objc dynamic var bodyWaist: String = "" // eo
    @objc dynamic var biceps: String = "" // so do bap tay

    func toProductUpdate() -> ProductUpdate{
        let product = ProductUpdate()
        product.pickUpDate = pickUpDate
        product.productColor = productColor
        product.price = price
        product.deposit = deposit
        product.note = note
        product.status = Int(status) ?? 0
        
        product.shoulder = shoulder
        product.chest = chest
        product.shirtLength = shirtLength
        product.sleeveLenght = sleeveLenght
        product.necklace = necklace
        product.bodyWaist = bodyWaist
        product.biceps = biceps
        return product
    }
}
