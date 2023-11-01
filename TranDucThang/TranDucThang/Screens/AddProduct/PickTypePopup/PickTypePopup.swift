//
//  PickTypePopup.swift
//  TranDucThang
//
//  Created by Tran Duc Tien Anh on 11/05/2023.
//

import Foundation
import UIKit

class PickTypePopup: BasePopup{
    
    class func show(_ callBack: @escaping ((TypeProduct) -> Void)){
        let p = PickTypePopup()
        p.callBack = callBack
        p.showBottom(nil)
    }
    
    var callBack: ((TypeProduct) -> Void)?
    override func initViews_() {
        super.initViews_()
        Bundle.main.loadNibNamed(PickTypePopup.identify, owner: self)
        addSubview(vContent)
        vContent.frame.size.width = .kScreenWidth
        vContent.frame.size.height = 320
        vContent.roundTopCorner(16)
        self.hiddenWhenTapOutside = true
    }
    
    @IBAction func didSelectPants(_ sender: Any) {
        callBack?(.pants)
        hide(nil)
    }
    
    @IBAction func didSelectShirt(_ sender: Any) {
        callBack?(.shirt)
        hide(nil)
    }
    
    @IBAction func didSelectVest(_ sender: Any) {
        callBack?(.vest)
        hide(nil)
    }
}
