//
//  VestModel.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 09/08/2022.
//

import Foundation
import RealmSwift

class VestModel: ProductModel {
    @objc dynamic var total: String = "" // tong
    @objc dynamic var long: String = "" // dai
    @objc dynamic var chest: String = "" // nguc
    @objc dynamic var bodyWaist: String = "" // eo
    @objc dynamic var butt: String = "" // mong
    @objc dynamic var arm: String = "" // bap tay
    @objc dynamic var withinArmpit: String = "" // vong nach
    @objc dynamic var hand: String = "" // tay
    @objc dynamic var horizontalFront: String = "" // ngang truoc
    @objc dynamic var horizontalBack: String = "" // ngang sau
    @objc dynamic var necklace: String = "" // vong co
    
    func toProductUpdate() -> ProductUpdate{
        let product = ProductUpdate()
        product.pickUpDate = pickUpDate
        product.productColor = productColor
        product.price = price
        product.deposit = deposit
        product.note = note
        product.status = Int(status) ?? 0
        
        product.total = total
        product.long = long
        product.chest = chest
        product.bodyWaist = bodyWaist
        product.butt = butt
        product.arm = arm
        product.withinArmpit = withinArmpit
        product.hand = hand
        product.horizontalFront = horizontalFront
        product.horizontalBack = horizontalBack
        product.necklace = necklace
        return product
    }
  }

