//
//  UIView+Autolayout.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 29/07/2022.
//

import Foundation
import UIKit

extension UIView {
    /**Add contraint width or height*/
    private func ALAddWH(_ att:NSLayoutConstraint.Attribute, _ cnt:CGFloat,relateBy:NSLayoutConstraint.Relation = .equal,multiplier:CGFloat = 1.0) {
        guard att == .width || att == .height else {
            return
        }
        let c = NSLayoutConstraint(item: self, attribute: att, relatedBy: relateBy, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cnt)
        self.addConstraint(c)
    }
    func ALAddWidth(_ cnt:CGFloat,_ relateBy:NSLayoutConstraint.Relation = .equal,multiplier:CGFloat = 1.0) {
        
        ALAddWH(.width,cnt , relateBy: relateBy, multiplier: multiplier)
    }
    func ALAddHeight(_ cnt:CGFloat,_ relateBy:NSLayoutConstraint.Relation = .equal,multiplier:CGFloat = 1.0) {
        
        ALAddWH(.height,cnt , relateBy: relateBy, multiplier: multiplier)
    }
    
    /**Add Layoutcontraint left,right,top,bottom relative with toView. If toView = nil, toView = superView*/
    func ALAdd(_ att:NSLayoutConstraint.Attribute,_ padding:CGFloat=0,toView:UIView?=nil) {
        guard let vSuper = self.superview else {
            return
        }
        if att == .width || att == .height {
            //chưa code
            return
        }

        let view2 = toView ?? vSuper
        let isSupper = view2 == vSuper
        var att2 = att
        
        var ppading = padding
        if !isSupper {

            switch(att) {
            case .leading:
                att2 = .trailing
                break
            case .top:
                att2 = .bottom
                break
            default:
                break
            }
        }
        if isSupper {
            //vs Super: pading bị ngược
            if att2 == .bottom || att2 == .trailing {
                ppading = -ppading
            }
        }
        
        let c = NSLayoutConstraint(item: self, attribute: att, relatedBy: .equal, toItem: view2, attribute: att2, multiplier: 1, constant: ppading)
        vSuper.addConstraint(c)
    }
}

/**Horizontal and vertical align**/
enum HVAlign {
    /**Align to LEFT*/
    case left(CGFloat)
    /**Align to Right*/
    case right(CGFloat)
    /**Align to TOP*/
    case top(CGFloat)
    /**Align to Center*/
    case center(CGFloat)
    /**Align to Bottom*/
    case bottom(CGFloat)
    /**Fit to supperview*/
    case fit(CGFloat,CGFloat)
}

extension Array where Element : UIView {
    
    /**Add autolayout horizontal cells */
    func horizontal(x:CGFloat = 0,_ padding:CGFloat = 0,align:HVAlign = .fit(0, 0)) {
        guard self.notEmpty else {
            return
        }
        //for autolayout
        var vBefore:Element? = nil
        
        for vSub in self {
            let vSuper = vSub.superview
            if vSuper == nil {
                continue
            }
            let pLeft = vBefore != nil ? padding : x
            vSub.ALAdd(.leading, pLeft, toView: vBefore)

            switch align {
            case .top(let top):
                vSub.ALAdd(.top, top)
                break
            case .center(let center):
                vSub.ALAdd(.centerY, center)
                break
            case .bottom(let bottom):
                vSub.ALAdd(.bottom, bottom)
                break
            case .fit(let top, let bottom):
                vSub.ALAdd(.top, top)
                vSub.ALAdd(.bottom, bottom)
                break
            default:
                break
            }
            
            if vSub == self.last {
                vSub.ALAdd(.trailing, x)
            }

            vBefore = vSub
        }
    }
    
    /**Add autolayout vertical cells */
    func vertical(y:CGFloat = 0,_ padding:CGFloat = 0,align:HVAlign = .fit(0,0)) {
        guard self.notEmpty else {
            return
        }
        
        var vBefore:Element? = nil
        
        for vSub in self {
            let vSuper = vSub.superview
            if vSuper == nil {
                continue
            }
            let pTop = vBefore != nil ? padding : y
            vSub.ALAdd(.top, pTop, toView: vBefore)

            switch align {
            case .left(let left):
                vSub.ALAdd(.leading, left)
                break
            case .right(let right):
                vSub.ALAdd(.trailing, right)
                break
            case .center(let center):
                vSub.ALAdd(.centerX, center)
                break
            case .fit(let left, let right):
                vSub.ALAdd(.leading, left)
                vSub.ALAdd(.trailing, right)
                break
            default:
                break
            }
            if vSub == self.last {
                vSub.ALAdd(.bottom, y)
            }
            vBefore = vSub
        }
    }
}
