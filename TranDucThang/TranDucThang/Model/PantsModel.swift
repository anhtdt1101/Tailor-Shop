//
//  PantsModel.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 09/08/2022.
//

import Foundation
import RealmSwift

class PantsModel: ProductModel {
    @objc dynamic var waist: String = "" // bung
    @objc dynamic var butt: String = "" // mong
    @objc dynamic var long: String = "" // bap tay
    @objc dynamic var trouserLeg: String = "" // ong quan
    @objc dynamic var thigh: String = "" // dui
    @objc dynamic var calf: String = "" // bap chan
    @objc dynamic var crotch: String = "" // dung quan
    
    func toProductUpdate() -> ProductUpdate{
        let product = ProductUpdate()
        product.pickUpDate = pickUpDate
        product.productColor = productColor
        product.price = price
        product.deposit = deposit
        product.note = note
        product.status = Int(status) ?? 0
        
        product.waist = waist
        product.butt = butt
        product.long = long
        product.trouserLeg = trouserLeg
        product.thigh = thigh
        product.calf = calf
        product.crotch = crotch
        return product
    }
}

