//
//  VVThemeManager.swift
//  VVBASE
//
//  Created by Anh Nguyen on 24/05/2022.
//

import UIKit

enum VVTheme: Int {
    case theme1
    case theme2
    case theme3
    
    var backgroundColor: UIColor {
        switch self {
        case .theme1:
            return UIColor(hexString: "005baa")
        case .theme2:
            return UIColor(hexString: "ffffff")
        case .theme3:
            return UIColor(hexString: "ffffff")
        }
    }
    
    // Main color of app
    var mainColor: UIColor {
        switch self {
        case .theme1:
            return UIColor(hexString: "")
        case .theme2:
            return UIColor(hexString: "")
        case .theme3:
            return UIColor(hexString: "")
        }
    }
    
    var titleTextColor: UIColor {
        switch self {
        case .theme1:
            return UIColor(hexString: "")
        case .theme2:
            return UIColor(hexString: "")
        case .theme3:
            return UIColor(hexString: "")
        }
    }
    
    var subtitleTextColor: UIColor {
        switch self {
        case .theme1:
            return UIColor(hexString: "")
        case .theme2:
            return UIColor(hexString: "")
        case .theme3:
            return UIColor(hexString: "")
        }
    }
    
    var titleTabbarColorDefault: UIColor {
        switch self {
        case .theme1:
            return UIColor(hexString: "b8b8b8")
        case .theme2:
            return UIColor(hexString: "b8b8b8")
        case .theme3:
            return UIColor(hexString: "b8b8b8")
        }
    }
    
    var titleTabbarColorHighlight: UIColor {
        return .cBlue
    }
}

let SelectedThemeKey = "SelectedTheme"

class VVThemeManager {
    static func currentTheme() -> VVTheme {
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
                    return VVTheme(rawValue: storedTheme)!
                } else {
                    return .theme1
                }
    }
    
    static func applyTheme(theme: VVTheme) {
           // First persist the selected theme using NSUserDefaults.
           UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
           UserDefaults.standard.synchronize()

           // You get your current (selected) theme and apply the main color to the tintColor property of your application’s window.
//           let sharedApplication = UIApplication.shared
//           sharedApplication.delegate?.window??.tintColor = theme.mainColor
//
//           UINavigationBar.appearance().barStyle = theme.barStyle
//           UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)
//           UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
//           UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")
//
//           UITabBar.appearance().barStyle = theme.barStyle
//           UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage
//
//           let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
//           let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
//           UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator
//
//           let controlBackground = UIImage(named: "controlBackground")?.withRenderingMode(.alwaysTemplate)
//               .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
//           let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?
//               .withRenderingMode(.alwaysTemplate)
//               .resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
//
//           UISegmentedControl.appearance().setBackgroundImage(controlBackground, for: .normal, barMetrics: .default)
//           UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, for: .selected, barMetrics: .default)
//
//           UIStepper.appearance().setBackgroundImage(controlBackground, for: .normal)
//           UIStepper.appearance().setBackgroundImage(controlBackground, for: .disabled)
//           UIStepper.appearance().setBackgroundImage(controlBackground, for: .highlighted)
//           UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), for: .normal)
//           UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), for: .normal)
//
//           UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
//           UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
//               .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)), for: .normal)
//           UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
//               .withRenderingMode(.alwaysTemplate)
//               .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)), for: .normal)
//
//           UISwitch.appearance().onTintColor = theme.mainColor.withAlphaComponent(0.3)
//           UISwitch.appearance().thumbTintColor = theme.mainColor
       }
}


