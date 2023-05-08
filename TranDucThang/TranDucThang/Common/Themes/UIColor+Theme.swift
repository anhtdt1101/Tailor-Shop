//
//  UIColor+Theme.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 06/06/2022.
//

import Foundation
import UIKit
//MARK: extension UIColor + Theme
extension UIColor {
    /**hex = f1f1f1*/
    static var cSeparator: UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("f0f0f0")
        case .theme2:
            return .hex("f0f0f0")
        case .theme3:
            return .hex("f0f0f0")
        }
    }
    /**hex = f0f0f0*/
    static var cLoading: UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("f0f0f0")
        case .theme2:
            return .hex("f0f0f0")
        case .theme3:
            return .hex("f0f0f0")
        }
    }
    /**hex = ffebed*/
    static var cRedLight: UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("ffebed")
        case .theme2:
            return .hex("ffebed")
        case .theme3:
            return .hex("ffebed")
        }
    }
    /**hex = e50019**/
   static var cRed:UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("e50019")
        case .theme2:
            return .hex("e50019")
        case .theme3:
            return .hex("e50019")
        }
    }
    /**hex = 005fcc**/
    static var cBlueLight:UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("005fcc")
        case .theme2:
            return .hex("005fcc")
        case .theme3:
            return .hex("005fcc")
        }
    }
    
    static var cYaleBlue: UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("ebf4ff")
        case .theme2:
            return .hex("ebf4ff")
        case .theme3:
            return .hex("ebf4ff")
        }
    }
    /**hex = 004a9c**/
    static var cBlue:UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("004a9c")
        case .theme2:
            return .hex("004a9c")
        case .theme3:
            return .hex("004a9c")
        }
    }
    /**hex = 525252**/
    static var cGray:UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("525252")
        case .theme2:
            return .hex("525252")
        case .theme3:
            return .hex("525252")
        }
    }
    /**hex = f7f7f7**/
    static var cGrayBg:UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("f7f7f7")
        case .theme2:
            return .hex("f7f7f7")
        case .theme3:
            return .hex("f7f7f7")
        }
    }
    
    /**hex = 333333**/
    static var cBlack:UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("333333")
        case .theme2:
            return .hex("333333")
        case .theme3:
            return .hex("333333")
        }
    }
    /**hex = b8b8b8**/
    static var cPlaceHolder:UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("b8b8b8")
        case .theme2:
            return .hex("b8b8b8")
        case .theme3:
            return .hex("b8b8b8")
        }
    }
    
    static var cGreen: UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return .hex("00bfae")
        case .theme2:
            return .hex("00bfae")
        case .theme3:
            return .hex("00bfae")
        }
    }
    
    // Main color of app
    static var mainColor: UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return UIColor(hexString: "")
        case .theme2:
            return UIColor(hexString: "")
        case .theme3:
            return UIColor(hexString: "")
        }
    }
    
    static var titleTextColor: UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return UIColor(hexString: "")
        case .theme2:
            return UIColor(hexString: "")
        case .theme3:
            return UIColor(hexString: "")
        }
    }
    
    static var subtitleTextColor: UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return UIColor(hexString: "")
        case .theme2:
            return UIColor(hexString: "")
        case .theme3:
            return UIColor(hexString: "")
        }
    }
    
    static var borderColor: UIColor {
        switch VVThemeManager.currentTheme() {
        case .theme1:
            return UIColor(hexString: "D6D6D6")
        case .theme2:
            return UIColor(hexString: "D6D6D6")
        case .theme3:
            return UIColor(hexString: "D6D6D6")
        }
    }
}
