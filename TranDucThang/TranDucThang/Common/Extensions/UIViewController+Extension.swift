//
//  UIViewController+Extension.swift
//  TranDucThang
//
//  Created by Tran Duc Tien Anh on 08/05/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func isModal() -> Bool {
        if self.presentingViewController != nil {
            return true
        } else if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        } else if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
    
    class func initWithNibTemplate<T>() -> T {
        let nibName = String(describing: self)
        let viewcontroller = self.init(nibName: nibName, bundle: Bundle.main)
        return viewcontroller as! T
    }
    
    
    func getPreViewController() -> UIViewController? {
        if let controllersOnNavStack = self.navigationController?.viewControllers, let index = controllersOnNavStack.firstIndex(of: self) {
            if index > 0 {
                return controllersOnNavStack[index - 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    func showToast(message : String, font: UIFont) {
        var width = message.widthOfString(usingFont: font) + 50
        if width >= UIScreen.main.bounds.width {
            width = UIScreen.main.bounds.width - 30
        }
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - width/2, y: self.view.frame.size.height-150, width: width, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.numberOfLines = 0
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.9
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension UINavigationController {
    var rootViewController : UIViewController? {
        return viewControllers.first
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
    
    func containsViewController(ofKind kind: AnyClass) -> Bool {
        return self.viewControllers.contains(where: { $0.isKind(of: kind) })
    }
}

extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base
    }
}
