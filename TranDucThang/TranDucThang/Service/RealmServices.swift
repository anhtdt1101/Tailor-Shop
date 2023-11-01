//
//  RealmManager.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 18/08/2022.
//

import RealmSwift
import UIKit

class RealmServices {
    
    static let shared = RealmServices()
    
    var diskRealm: Realm {
        return try! Realm()
    }
    let inMemoryRealm: Realm
    
    private init() {
        let config = Realm.Configuration(inMemoryIdentifier: "inMemory")
        let inMemoryRealm = try! Realm(configuration: config)
        self.inMemoryRealm = inMemoryRealm
    }
    
    //*****************************************************************
    // MARK: - CRUD Utility Functions
    //*****************************************************************
    
    enum RealmType {
        case disk
        case inMemory
    }
    
    private func getRealm(type: RealmType) -> Realm {
        switch type {
        case .disk: return diskRealm
        case .inMemory: return self.inMemoryRealm
        }
    }
    
    func create<T: Object>(_ object: T, type: RealmType = .disk) {
        let realm = self.getRealm(type: type)
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?], type: RealmType = .disk) {
        let realm = self.getRealm(type: type)
        do {
            try realm.write {
                for (key,value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func delete<T: Object>(_ object: T, type: RealmType = .disk) {
        let realm = self.getRealm(type: type)
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAll(type: RealmType = .disk) {
        let realm = self.getRealm(type: type)
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
    func deleteRealmFiles() {
        guard let realmURL = Realm.Configuration.defaultConfiguration.fileURL else {
            return
        }
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        realmURLs.forEach { (url) in
            do {
                if FileManager.default.fileExists(atPath: url.absoluteString) {
                    try FileManager.default.removeItem(at: url)
                }
            } catch {
                print(error)
            }
        }
        
    }
    
    func saveObjects(objs: Object, type: RealmType = .disk) {
        let realm = self.getRealm(type: type)
        do {
            try realm.write {
                realm.add(objs, update: .all)
            }
        } catch {
            print(error)
        }
    }
    
    //*****************************************************************
    // MARK: - NotificationCenter
    //*****************************************************************
    func post(_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"),object:error)
    }
    
    func observerRealmErrors(in vc: UIViewController, completion: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("RealmError"), object: nil, queue: nil) { (notification) in
            completion(notification.object as? Error)
        }
    }
    
    func stopObservingErrors(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }
}
