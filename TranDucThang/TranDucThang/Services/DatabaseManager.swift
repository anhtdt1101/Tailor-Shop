//
//  DatabaseManager.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 18/08/2022.
//

import Foundation
import RealmSwift
//
//class DatabaseManager: NSObject {
//    static func insertClient(_ data: ClientModel,callback: ((Bool) -> Void)? = nil) {
//        let realm = RealmServices.shared.diskRealm
//        let predicate = NSPredicate(format: "phoneNumber == %@", data.phoneNumber)
//        let clients = realm.objects(ClientModel.self).filter(predicate)
//        if let dataSearch = clients.first, dataSearch.phoneNumber == data.phoneNumber{
//            callback?(false)
//        } else {
//            do {
//                try realm.write {
//                    realm.add(data.self, update: .all)
//                    callback?(true)
//                }
//            } catch {
//                debugPrint(error.localizedDescription)
//                callback?(false)
//            }
//        }
//    }
//    
//    static func update<T: Object>(_ object: T, with dictionary: [String: Any?], callback: ((Bool) -> Void)? = nil) {
//        let realm = RealmServices.shared.diskRealm
//        do {
//            try realm.write {
//                for (key,value) in dictionary {
//                    object.setValue(value, forKey: key)
//                }
//                callback?(true)
//            }
//        } catch {
//            print(error)
//            callback?(false)
//        }
//    }
//    
//    static func updateStatus(_ product: ProductModel, callback: ((Bool) -> Void)? = nil){
//        let realm = RealmServices.shared.diskRealm
//        do {
//            try realm.write {
//                if product.status == "0"{
//                    product.status = "1"
//                } else {
//                    product.status = "0"
//                }
//                callback?(true)
//            }
//        } catch {
//            print(error)
//            callback?(false)
//        }
//    }
//    
//    static func addShirt(_ data: ClientModel, _ shirt: ShirtModel,callback: ((Bool) -> Void)? = nil){
//        let realm = RealmServices.shared.diskRealm
//        let channels = realm.objects(ClientModel.self).compactMap({ $0 })
//        if let index = channels.firstIndex(where: {$0.phoneNumber == data.phoneNumber}) {
//            do {
//                try realm.write {
//                    shirt.product = 0
//                    channels[index].listShirt.append(shirt)
//                    callback?(true)
//                }
//            } catch {
//                debugPrint(error.localizedDescription)
//                callback?(false)
//            }
//        }
//    }
//    
//    static func addPants(_ data: ClientModel, _ pants: PantsModel,callback: ((Bool) -> Void)? = nil){
//        let realm = RealmServices.shared.diskRealm
//        let channels = realm.objects(ClientModel.self).compactMap({ $0 })
//        if let index = channels.firstIndex(where: {$0.phoneNumber == data.phoneNumber}) {
//            do {
//                try realm.write {
//                    pants.product = 1
//                    channels[index].listPants.append(pants)
//                    callback?(true)
//                }
//            } catch {
//                debugPrint(error.localizedDescription)
//                callback?(false)
//            }
//        }
//    }
//    
//    static func addVest(_ data: ClientModel, _ vest: VestModel,callback: ((Bool) -> Void)? = nil){
//        let realm = RealmServices.shared.diskRealm
//        let channels = realm.objects(ClientModel.self).compactMap({ $0 })
//        if let index = channels.firstIndex(where: {$0.phoneNumber == data.phoneNumber}) {
//            do {
//                try realm.write {
//                    vest.product = 2
//                    channels[index].listVest.append(vest)
//                    callback?(true)
//                }
//            } catch {
//                debugPrint(error.localizedDescription)
//                callback?(false)
//            }
//        }
//    }
//    
//    static func getAClient(_ data: ClientModel) -> ClientModel? {
//        let realm = RealmServices.shared.diskRealm
//        let predicate = NSPredicate(format: "phoneNumber == %@", data.phoneNumber)
//        let clients = realm.objects(ClientModel.self).filter(predicate)
//        if let dataSearch = clients.first, dataSearch.phoneNumber == data.phoneNumber{
//            return dataSearch
//        } else {
//            return nil
//        }
//    }
//    
//    static func getClient() -> [ClientModel] {
//        let realm = RealmServices.shared.diskRealm
//        let objects = realm.objects(ClientModel.self)
//        let sortedObjects = objects.sorted(byKeyPath: "phoneNumber", ascending: true)
//        return Array(sortedObjects)
//    }
//    
//    static func filterClient(_ text: String) -> [ClientModel] {
//        let realm = RealmServices.shared.diskRealm
//        let predicate = NSPredicate(format: "phoneNumber CONTAINS %@ || fullName CONTAINS %@", text,text)
//        let products = realm.objects(ClientModel.self).filter(predicate)
//        return Array(products)
//    }
//}
