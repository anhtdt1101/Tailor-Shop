//
//  VVUserdefault.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 03/07/2022.
//

import Foundation
extension Dictionary where Key == String {
    /**Save all key,value in to UserDefaults.standard and synchronize it*/
    func userSave() {
        for (key,value) in self {
            UserDefaults.set(key,value)
        }
        UserDefaults.standard.synchronize()
    }
}
extension String {
    /**Get value of key=self in UserDefaults.standard**/
    func userGetValue() -> Any? {
        let value = UserDefaults.get(self)
        return value
    }
}
extension UserDefaults {
    class func set(_ key:String,_ value:Any?) {
        let sKey = key.MD5()
        UserDefaults.standard.set(value, forKey: sKey)
    }
    class func get(_ key:String) -> Any? {
        let sKey = key.MD5()
        let value = UserDefaults.standard.value(forKey: sKey)
        return value
    }
    class func remove(_ key:String) {
        let sKey = key.MD5()
        UserDefaults.standard.removeObject(forKey: sKey)
    }
}


extension NotificationCenter {
    class func listen(_ target:Any,_ sel:Selector,_ name:NSNotification.Name) {
        NotificationCenter.default.addObserver(target, selector: sel, name: name, object: nil)
    }
    class func post(_ name:NSNotification.Name, _ object:Any? = nil) {
        NotificationCenter.default.post(name: name, object: object)
    }
}
