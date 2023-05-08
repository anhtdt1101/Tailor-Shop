//
//  VVButton.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 06/05/2022.
//

import Foundation
import UIKit

class VVButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        let font = self.titleLabel?.font .appFont()
        self.titleLabel?.font = font
        self.addTarget(self, action: #selector(methodTobeCalledEveryWhere), for: .touchUpInside)
    }
    
    func addUnderLine(with text: String, color: UIColor) {
        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : self.titleLabel?.font as Any,
            NSAttributedString.Key.foregroundColor : color,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: text,
                                                        attributes: yourAttributes)
        self.setAttributedTitle(attributeString, for: .normal)
    }
    
    @objc func methodTobeCalledEveryWhere () {
        self.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isUserInteractionEnabled = true
        }
    }
    
    func blueBtnDisable(_ isDisable: Bool) {
        self.backgroundColor = isDisable ? UIColor.cPlaceHolder : UIColor.cBlue
        self.isEnabled = !isDisable
    }
}

extension UIButton {
    func disable(_ isDisable: Bool) {
        self.isEnabled = !isDisable
        if isDisable {
            self.alpha = 0.3
        } else {
            self.alpha = 1
        }
    }
}

fileprivate var k_vvbutton = 0
extension UIButton {
    var touchUpinSide:VVVoidBlock? {
        set{
            self.addTarget(self, action: #selector(_touchUpInside), for: .touchUpInside)
            objc_setAssociatedObject(self, &k_vvbutton, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            if let block = objc_getAssociatedObject(self, &k_vvbutton) as? VVVoidBlock {
                return block
            }
            return nil
        }
    }
    
    @objc func _touchUpInside() {
        if let block = self.touchUpinSide {
            block()
        }
    }
}

/**Button text only (no border)*/
class VVButtonTitle : VVButton {
    @IBInspectable var vvColor:UIColor = .cBlue
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vvRadius = self.height/2.0
        self.setTitleColor(vvColor, for: .normal)
        let fSize = self.titleLabel?.font.pointSize ?? CGFloat.fSz15
        self.titleLabel?.font = .bold(fSize)
    }
}
class VVButtonBlue : VVButton {
    @IBInspectable var vvColor:UIColor = .cBlue
    @IBInspectable var disable:Bool = false {
        didSet {
            self.backgroundColor = disable ? .cPlaceHolder : vvColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vvRadius = self.height/2.0
        self.backgroundColor = vvColor
        self.setTitleColor(.white, for: .normal)
        
        let fSize = self.titleLabel?.font.pointSize ?? CGFloat.fSz15
        self.titleLabel?.font = .bold(fSize)
    }
}

class VVButtonBorder : VVButton {
    @IBInspectable var vvColor:UIColor = .cBlue
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vvRadius = self.height/2.0
        self.vvBorderColor = vvColor
        self.vvBorderWidth = 1
        self.setTitleColor(vvColor, for: .normal)
        let fSize = self.titleLabel?.font.pointSize ?? CGFloat.fSz15
        self.titleLabel?.font = .bold(fSize)
    }
}
