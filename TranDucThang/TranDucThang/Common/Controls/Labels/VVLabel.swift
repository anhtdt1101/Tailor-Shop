//
//  VVLabel.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 10/05/2022.
//

import Foundation
import UIKit

class VVLabel: UILabel {
    // upercase text
    @IBInspectable public var uppercase: Bool = false
    var vvStyle: VVLabelStyle = .regular {
        didSet {
            self.textColor = vvStyle.color()
            self.font = vvStyle.font()
        }
    }
    
    override public var text: String? {
        set(newValue) {
            super.text = uppercase ? newValue?.uppercased() : newValue
        }
        get {
            return super.text
        }
    }
    override var font: UIFont! {
        get{return super.font}
        set{super.font = newValue.appFont()}
    }
    override func awakeFromNib() {
        // set font cho label
        super.awakeFromNib()
    }

}

@objc enum VVLabelStyle: Int {
    case title
    case subTitle
    case desc
    case headerTitle
    case regular
    case error
    
    func color() -> UIColor {
        switch self {
        case .title, .subTitle, .headerTitle:
            return .cBlack
        case .desc, .regular:
            return .cGray
        case .error:
            return .cRed
        }
    }
    
    func font() -> UIFont {
        switch self {
        case .title:
            return .bold(.fSz15)
        case .subTitle:
            return .bold(.fSz13)
        case .desc:
            return .regular(.fSz13)
        case .headerTitle:
            return .bold(.fSz18)
        case .regular, .error:
            return .regular(.fSz13)
        }
    }
}
