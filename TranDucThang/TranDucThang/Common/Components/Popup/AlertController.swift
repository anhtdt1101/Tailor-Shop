//
//  AleartControlelr.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 22/10/2023.
//

import Foundation
import UIKit

private var window: UIWindow!
extension UIAlertController {
    
    private static var _aletrWindow: UIWindow?
    private static var aletrWindow: UIWindow {
        if let window = _aletrWindow {
            return window
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UIViewController()
            window.windowLevel = UIWindow.Level.alert + 1
            window.backgroundColor = .clear
            _aletrWindow = window
            return window
        }
    }
    
    class func showPopUp(_ viewController: UIViewController,_ message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    class func showConfirm(_ viewController: UIViewController,_ message: String, callback: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            callback?()
        }))
        alert.addAction(UIAlertAction(title: "Đóng", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    func presentGlobally(animated: Bool, completion: (() -> Void)? = nil) {
        UIAlertController.aletrWindow.makeKeyAndVisible()
        UIAlertController.aletrWindow.isHidden = false
        UIAlertController.aletrWindow.rootViewController?.present(self, animated: animated, completion: completion)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIAlertController.aletrWindow.isHidden = true
    }
    
}

extension UIButton {
    func blueBtnDisable(_ isDisable: Bool) {
        self.backgroundColor = isDisable ? UIColor.lightGray : UIColor.blue
        self.isEnabled = !isDisable
    }
}
