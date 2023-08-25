//
//  VVContant.swift
//  VVBASE
//
//  Created by Tran Duc Tien Anh on 26/05/2022.
//

import Foundation
import UIKit

extension UIColor {
    static var kGray = UIColor.gray
    static var kBlue = UIColor.blue
}

extension CGFloat {
    static let kScreenWidth = CGRect.kScreenBound.width
    static let kScreenHeight = CGRect.kScreenBound.height
    
    /**Thicknes of separator view*/
    static let kSepThicknes = 1/UIScreen.main.scale
}

extension CGRect {
    static func vvRect(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) -> CGRect {
        return .init(x: x, y: y, width: width, height: height)
    }
    static let kScreenBound = UIScreen.main.bounds
}

extension CGPoint {
    static func vvPoint(_ x:CGFloat,_ y:CGFloat) -> CGPoint {
        return .init(x: x, y: y)
    }
}

extension CGSize {
    static func vvSize(_ width:CGFloat,_ height:CGFloat) -> CGSize {
        return .init(width: width, height: height)
    }
}

extension UIEdgeInsets {
    static func vvInset(_ top:CGFloat,_ left:CGFloat,_ bottom:CGFloat,_ right:CGFloat) -> Self {
        return .init(top: top, left: left, bottom: bottom, right: right)
    }
}
