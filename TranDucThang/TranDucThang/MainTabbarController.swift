//
//  MainTabbarController.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 23/10/2023.
//

import Foundation
import UIKit

class MainTabbarController: UITabBarController {
    static var shared = MainTabbarController()
    
    private var homeViewController: UINavigationController?
    private var clientViewController: UINavigationController?
    private var subViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewcontrollers()
    }
    
    // MARK: Setup child viewcontrollers
    private func setupChildViewcontrollers() {
        homeViewController = UINavigationController(rootViewController: HomeVC())
        clientViewController = UINavigationController(rootViewController: ClientVC())
        
        homeViewController?.tabBarItem = UITabBarItem(title: "Trang chủ",
                                                      image: UIImage(systemName: "house"),
                                                      selectedImage: UIImage(systemName: "house.fill"))
        
        clientViewController?.tabBarItem = UITabBarItem(title: "Khách hàng",
                                                      image: UIImage(systemName: "person"),
                                                      selectedImage: UIImage(systemName: "person.fill"))
        
        if let viewcontroller = homeViewController {
            subViewControllers.append(viewcontroller)
        }
        if let viewcontroller = clientViewController {
            subViewControllers.append(viewcontroller)
        }
       
        viewControllers = subViewControllers
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension UIDevice {
    var hasNotch: Bool {
        if UIApplication.shared.windows.count == 0 { return false }
        let top = UIApplication.shared.windows[0].safeAreaInsets.top
        return top > 20
    }
}

extension UITabBarController {
    func vvTabbarStyle() {
        // ios 13.0 and above
        let appearance = tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundEffect = nil
        // need to set background because it is black in standardAppearance
        appearance.backgroundColor = .clear
        tabBar.standardAppearance = appearance
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
