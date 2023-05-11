//
//  BasePopup.swift
//  TranDucThang
//
//  Created by Tran Duc Tien Anh on 11/05/2023.
//

import Foundation
import UIKit

class BasePopup: UIView{
    @IBOutlet var vContent: UIView!

    private static var bpTag = 20220524
    var hiddenWhenTapOutside: Bool = true
    private var isShowBottom = false
    private var isShowTop = false
    private let bgBtn = UIButton()
    var backgroundView: UIView = UIView()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: .kScreenWidth, height: .kScreenHeight))
        initViews_()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews_()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews_()
    }
    
    //MARK: Override.able
    func initViews_() {
        guard let window = UIView.appWindow() else { return }
        self.frame = window.bounds
        backgroundView.frame = self.bounds
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.5
        
        bgBtn.frame = self.bounds
        addSubview(bgBtn)
        bgBtn.addTarget(self, action: #selector(onSelectBackground), for: .touchUpInside)
        self.tag = BasePopup.bpTag
    }
    
    
    @IBAction @objc func onSelectBackground() {
        if !hiddenWhenTapOutside {
            return
        }
        hide(nil)
    }
    
    func show(_ callback: (() -> Void)? = nil) {
        isShowBottom = false
        _show(center:true, callback)
    }
    func showBottom(_ callback: (() -> Void)?) {
        isShowBottom = true
        _show(center:false, callback)
    }
 
    func showTop(_ callback: (() -> Void)?){
        isShowTop = true
        guard let window = UIView.appWindow() else { return }
        if backgroundView.superview == nil {
            window.addSubview(backgroundView)
        }
        if self.superview == nil {
            window.addSubview(self)
        }
        backgroundView.alpha = 0
        vContent.frame.origin.y = 0
        self.frame.origin.y = -(vContent.cHeight?.constant ?? 200)
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
            self.backgroundView.alpha = 0.5
            self.frame.origin.y = 0
        } completion: { _ in
            callback?()
        }
    }
    
    func hideTop(_ cb:(() -> Void)?) {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
            self.frame.origin.y = -(self.vContent.cHeight?.constant ?? 200)
        } completion: { _ in
            UIView .animate(withDuration: 0.3) {
                self.backgroundView.alpha = 0.0
            } completion: { ok in
                self.backgroundView.removeFromSuperview()
                cb?()
                self.removeFromSuperview()
            }
        }
    }
    
    private func _show(center:Bool = true, _ callback: (() -> Void)?) {
        guard let window = UIView.appWindow() else { return }
        if backgroundView.superview == nil {
            window.addSubview(backgroundView)
        }
        if self.superview == nil {
            window.addSubview(self)
        }
        //animate
        backgroundView.alpha = 0
        
        if center {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } else {
            vContent.frame.origin.y = self.frame.size.height - vContent.frame.size.height
            self.frame.origin.y = 100
            vContent.frame.origin.x = (self.frame.size.width - vContent.frame.size.width)/2
        }
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
            self.backgroundView.alpha = 0.5
            if center {
                self.transform = .identity
            }else {
                self.frame.origin.y = 0
            }
        } completion: { _ in
            callback?()
        }
    }
    
    func hide(_ cb:(() -> Void)?) {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
            if self.isShowBottom {
                self.vContent.frame.origin.y = .kScreenHeight
            }else {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            }
        } completion: { _ in
            UIView .animate(withDuration: 0.3) {
                self.backgroundView.alpha = 0.0
            } completion: { ok in
                self.backgroundView.removeFromSuperview()
                cb?()
                self.removeFromSuperview()
            }
        }
    }
    
    deinit {
        debugPrint("~~~[\(String(describing: self)) deinit]")
    }
    
}
