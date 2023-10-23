//
//  BaseVC.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 09/08/2022.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    @IBOutlet weak var navBarView: NavBarView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbarView()
        print("~~~~~\(type(of: self)) viewDidLoad~~~~")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("[\(Self.self) \(#function)]:ZZZ")
    }
    
    deinit {
        print("~~~[\(type(of: self)) deinit]~~~")
    }
    
    //MARK: Nav bar
    override var title: String? {
        didSet {
            setNavTitle(title)
        }
        
    }
    
    func setNavTitle(_ title: String?) {
        if let title = title {
            guard let _ = navBarView?.superview else {
                return
            }
            navBarView?.onBackAction = { [weak self] in
                self?.onNavbarBack()
            }
        }
    }
    
    func setupNavbarView() {
        // override this func
    }
    
    class func initWithNib() -> Self {
        let bundle = Bundle.main
        let fileManege = FileManager.default
        let nibName = String(describing: self)
        if let pathXib = bundle.path(forResource: nibName, ofType: "xib") {
            if fileManege.fileExists(atPath: pathXib) {
                return initWithNibTemplate()
            }
        }
        if let pathStoryboard = bundle.path(forResource: nibName, ofType: "storyboard") {
            if fileManege.fileExists(atPath: pathStoryboard) {
                return initWithDefautlStoryboard()
            }
        }
        return initWithNibTemplate()
    }
    
    class func initWithDefautlStoryboard() -> Self {
        let className = String(describing: self)
        return instantiateFromStoryboardHelper(storyboardName: className, storyboardId: className)
    }
    
    private class func instantiateFromStoryboardHelper<T>(storyboardName: String, storyboardId: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        return controller
    }
    
    @IBAction func popViewController() {
        onNavbarBack()
    }
    
    func onNavbarBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
