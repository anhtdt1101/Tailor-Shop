//
//  ClientModel.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 09/08/2022.
//

import Foundation
import RealmSwift

class ClientModel: Object {
    @objc dynamic var fullName: String = "" // ho va ten
    @objc dynamic var addDress: String = "" // dia chi
    @objc dynamic var phoneNumber: String = "" // so dien thoai
    @objc dynamic var note: String = "" // ghi chu
    dynamic let listShirt: List<ShirtModel> = List()
    dynamic let listPants: List<PantsModel> = List()
    dynamic let listVest: List<VestModel> = List()
    
    override static func primaryKey() -> String? {
        return "phoneNumber"
    }
}

