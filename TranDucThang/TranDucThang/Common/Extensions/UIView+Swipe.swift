//
//  UIView+Swipe.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 07/07/2022.
//

import Foundation
import UIKit
import AVFoundation
typealias SwipeBlock = (UIView,UIGestureRecognizer)->Void
enum SwipeDirection {
    case left
    case right
    case top
    case bottom
    
    var selector:Selector {
        switch self {
        case .left:
            return #selector(UIView.didSwipeLeft)
        case .right:
            return #selector(UIView.didSwipeRight)
        case .top:
            return #selector(UIView.didSwipeTop)
        case .bottom:
            return #selector(UIView.didSwipeBottom)
        }
    }
    
    func gesture(_ view:UIView) -> UISwipeGestureRecognizer {
        let gesture = UISwipeGestureRecognizer(target: view, action: self.selector)
        switch self {
        case .left:
            gesture.direction = .left
        case .right:
            gesture.direction = .right
        case .top:
            gesture.direction = .up
        case .bottom:
            gesture.direction = .down
        }
        
        view.addGestureRecognizer(gesture)
        return gesture
    }
}

fileprivate var kNodeUIViewSwipe = 0
typealias SwipeDict = [SwipeDirection:VVSwipe]

extension UIView {
    private var dSwipes:SwipeDict {
        get {
            if let dict = objc_getAssociatedObject(self, &kNodeUIViewSwipe) as? SwipeDict {
                return dict
            }
            let dict:SwipeDict = [:]
            self.dSwipes = dict
            return dict
        }
        set {
            objc_setAssociatedObject(self, &kNodeUIViewSwipe, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    func swipe(_ direction:SwipeDirection, _ block:@escaping SwipeBlock) {
        vvAddSwipe(direction, block)
    }
    func onSwipeLeft(_ block:@escaping SwipeBlock) {
        vvAddSwipe(.left, block)
    }
    func onSwipeRight(_ block:@escaping SwipeBlock) {
        vvAddSwipe(.right, block)
    }
    func onSwipeTop(_ block:@escaping SwipeBlock) {
        vvAddSwipe(.top, block)
    }
    func onSwipeBottom(_ block:@escaping SwipeBlock) {
        vvAddSwipe(.bottom, block)
    }
    
    private func vvAddSwipe(_ direction:SwipeDirection,_ block:@escaping SwipeBlock) {
        
        //add gesture
        let gesture = direction.gesture(self)
        
        //save to dict
        let vv = VVSwipe(gesture,block)
        self.dSwipes[direction] = vv
    }
    
    func SwipeRemove(_ direction:SwipeDirection) {
        if let vv = dSwipes[direction] {
            removeGestureRecognizer(vv.gesture)
            dSwipes.removeValue(forKey: direction)
        }
    }
    
    //MARK: Handler gesture
    @objc func didSwipeLeft() {
        if let vv = dSwipes[.left] {
            vv.block(self,vv.gesture)
        }
    }
    @objc func didSwipeRight() {
        if let vv = dSwipes[.right] {
            vv.block(self,vv.gesture)
        }
    }
    @objc func didSwipeTop() {
        if let vv = dSwipes[.top] {
            vv.block(self,vv.gesture)
        }
    }
    @objc func didSwipeBottom() {
        if let vv = dSwipes[.bottom] {
            vv.block(self,vv.gesture)
        }
    }
}




struct VVSwipe {
    var block:SwipeBlock!
    var gesture:UISwipeGestureRecognizer!
    
    init(_ gesture:UISwipeGestureRecognizer,_ block:@escaping SwipeBlock) {
        self.block = block
        self.gesture = gesture
    }
}


