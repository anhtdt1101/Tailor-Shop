//
//  UIFont+Extension.swift
//  VVBASE
//
//  Created by Anh Nguyen on 27/05/2022.
//

import UIKit

extension UIFont {
    public enum FontType: String {
        case bold = "-Bold"
        case medium = "-Medium"
        case regular = "-Regular"
        case semiBold = "-Semibold"
    }
    
    static func customFont(_ type: FontType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "System\(type.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    func appFont() -> UIFont {
        var font = UIFont.customFont()
        let fName = self.fontName.trim().lowercased()
        let fSize = self.pointSize

        if fName.hasSuffix("bold") {
            font = UIFont.customFont(.bold, size: fSize)
        } else if fName.hasSuffix("medium") {
            font = UIFont.customFont(.medium, size: fSize)
        } else {
            font = UIFont.customFont(.regular, size: fSize)
        }
        return font
    }
    
    class func medium(_ size:CGFloat) -> UIFont {
        return .customFont(.medium, size: size)
    }
    class func regular(_ size:CGFloat) -> UIFont {
        return .customFont(.regular, size: size)
    }
    class func bold(_ size:CGFloat) -> UIFont {
        return .customFont(.bold, size: size)
    }
    class func semiBold(_ size:CGFloat) -> UIFont {
        return .customFont(.semiBold, size: size)
    }
}

