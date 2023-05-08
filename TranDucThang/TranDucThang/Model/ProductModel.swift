//
//  ProductModel.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 09/08/2022.
//

import Foundation
import RealmSwift


enum TypeProduct {
    case vest
    case shirt
    case pants
    
    var title: String {
        switch self {
        case .vest:
            return "Áo Vest"
        case .shirt:
            return "Áo Sơ Mi"
        case .pants:
            return "Quần"
        }
    }
    
    var type: Int {
        switch self {
        case .vest:
            return 2
        case .shirt:
            return 0
        case .pants:
            return 1
        }
    }
    
    static func typeProduct(_ type: Int) -> TypeProduct {
        if type == 0 {
            return .shirt
        } else if type == 1{
            return .pants
        } else if type == 2{
            return .vest
        } else {
            return .shirt
        }
    }
}

class ProductUpdate {
    var status: Int = 0
    var product: Int = 0
    var pickUpDate: String = ""
    var productColor: String = ""
    var price: String = ""
    var deposit: String = ""
    var note: String = "Ghi chú"
    
    var shoulder: String = "" // vai
    var chest: String = "" // nguc
    var shirtLength: String = "" // chieu dai ao
    var sleeveLenght: String = "" // chieu dai tay ao
    var necklace: String = "" // co
    var bodyWaist: String = "" // eo
    var biceps: String = "" // so do bap tay
    
    var waist: String = "" // bung
    var butt: String = "" // mong
    var long: String = "" // bap tay
    var trouserLeg: String = "" // ong quan
    var thigh: String = "" // dui
    var calf: String = "" // bap chan
    var crotch: String = "" // dung quan
    
    var total: String = "" // tong
    var arm: String = "" // bap tay
    var withinArmpit: String = "" // vong nach
    var hand: String = "" // tay
    var horizontalFront: String = "" // ngang truoc
    var horizontalBack: String = "" // ngang sau
    
    init(){}
    
    func toPants() -> PantsModel {
        let data = PantsModel()
        data.product = 1
        data.pickUpDate = pickUpDate
        data.productColor = productColor
        data.price = price
        data.deposit = deposit
        data.note = note
        
        data.waist = waist
        data.butt = butt
        data.long = long
        data.trouserLeg = trouserLeg
        data.thigh = thigh
        data.calf = calf
        data.crotch = crotch
        return data
    }
    
    func toDictPants() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["pickUpDate"] = pickUpDate
        dict["productColor"] = productColor
        dict["price"] = price
        dict["deposit"] = deposit
        dict["note"] = note
        dict["waist"] = waist
        dict["butt"] = butt
        dict["long"] = long
        dict["trouserLeg"] = trouserLeg
        dict["thigh"] = thigh
        dict["calf"] = calf
        dict["crotch"] = crotch
        return dict
    }
    
    
    func toShirts() -> ShirtModel {
        let data = ShirtModel()
        data.product = 0
        data.pickUpDate = pickUpDate
        data.productColor = productColor
        data.price = price
        data.deposit = deposit
        data.note = note
        
        data.shoulder = shoulder
        data.chest = chest
        data.shirtLength = shirtLength
        data.sleeveLenght = sleeveLenght
        data.necklace = necklace
        data.bodyWaist = bodyWaist
        data.biceps = biceps
        return data
    }
    
    
    func toDictShirt() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["pickUpDate"] = pickUpDate
        dict["productColor"] = productColor
        dict["price"] = price
        dict["deposit"] = deposit
        dict["note"] = note
        dict["shoulder"] = shoulder
        dict["chest"] = chest
        dict["shirtLength"] = shirtLength
        dict["sleeveLenght"] = sleeveLenght
        dict["necklace"] = necklace
        dict["bodyWaist"] = bodyWaist
        dict["biceps"] = biceps
        return dict
    }
    
    func toVest() -> VestModel {
        let data = VestModel()
        data.product = 2
        data.pickUpDate = pickUpDate
        data.productColor = productColor
        data.price = price
        data.deposit = deposit
        data.note = note
        
        data.total = total
        data.long = long
        data.chest = chest
        data.bodyWaist = bodyWaist
        data.butt = butt
        data.arm = arm
        data.withinArmpit = withinArmpit
        data.hand = hand
        data.horizontalFront = horizontalFront
        data.horizontalBack = horizontalBack
        data.necklace = necklace
        return data
    }
    
    func toDictVest() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["pickUpDate"] = pickUpDate
        dict["productColor"] = productColor
        dict["price"] = price
        dict["deposit"] = deposit
        dict["note"] = note
        
        dict["total"] = total
        dict["long"] = long
        dict["chest"] = chest
        dict["bodyWaist"] = bodyWaist
        dict["butt"] = butt
        dict["arm"] = arm
        dict["withinArmpit"] = withinArmpit
        dict["hand"] = hand
        dict["horizontalFront"] = horizontalFront
        dict["horizontalBack"] = horizontalBack
        dict["necklace"] = necklace
        return dict
    }
}

class ProductModel: Object {
    @objc dynamic var product: Int = 0
    @objc dynamic var dateCreated: Date = Date()
    @objc dynamic var pickUpDate: String = ""
    @objc dynamic var productColor: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var deposit: String = ""
    @objc dynamic var note: String = ""
    @objc dynamic var status: String = "0"
    @objc dynamic var id: String = UUID().uuidString
    
    override class func primaryKey() -> String? {
        return "id"
    }

}
