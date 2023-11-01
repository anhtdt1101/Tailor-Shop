//
//  ClientModel.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 21/10/2023.
//

import Foundation
import RealmSwift

class RClientModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var fullName: String = "" // ho va ten
    @objc dynamic var addDress: String = "" // dia chi
    @objc dynamic var note: String = "" // ghi chu
    @objc dynamic var isWorker: Bool = false
    dynamic var phoneNumber: List<String> = List() // so dien thoai
    dynamic var listProduct: List<RProductModel> = List()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RClientModel {
    convenience init(uiModel: ClientModel) {
        self.init()
        self.fullName = uiModel.fullName
        self.addDress = uiModel.addDress
        self.note = uiModel.note
        self.isWorker = uiModel.isWorker
        self.phoneNumber.append(objectsIn: uiModel.phoneNumber)
        self.listProduct = List()
    }
    
    func toUIModel() -> ClientModel {
        var phoneNumerArr = [String]()
        for item in self.phoneNumber {
            phoneNumerArr.append(item)
        }
        return ClientModel(id: self.id,
                           fullName: self.fullName,
                           addDress: self.addDress,
                           note: self.note,
                           isWorker: self.isWorker,
                           phoneNumber: phoneNumerArr,
                           listProduct: [])
    }
}
