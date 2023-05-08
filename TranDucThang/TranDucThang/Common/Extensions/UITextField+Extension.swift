//
//  UITextField+Extension.swift
//  VVBASE
//
//  Created by Anh Nguyen on 30/05/2022.
//

import UIKit

extension UITextField {
    func isEmpty() -> Bool {
        if self.text?.count == 0 || self.text == nil {
            return true
        }
        
        return false
    }
    
    public func addPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    public func addIconLeft(image: UIImage) {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: image.size))
        imageView.image = image
        leftView = imageView
        leftViewMode = .always
    }
    
    public func addPaddingRight(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
    
    func beginEditting() {
        self.layer.borderColor = UIColor(red: 90/255, green: 233/255, blue: 192/255, alpha: 1).cgColor
        self.layer.borderWidth = 0.5
        self.layer.shadowColor = UIColor(red: 66/255, green: 233/255, blue: 172/255, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 1.0
        self.tintColor = UIColor(red: 90/255, green: 233/255, blue: 192/255, alpha: 1)
        self.layer.cornerRadius = 5
    }
    
    func endEditting() {
        self.layer.borderColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 0.5
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 1.0
        self.tintColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1.0)
        self.layer.cornerRadius = 5
    }
    
    func showEyeButton() {
        clearButtonMode = .never
        rightViewMode   = .always

        let eyeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        if self.isSecureTextEntry {
            eyeButton.setImage(UIImage(named: "ic_hide_password"), for: .normal)
        } else {
            eyeButton.setImage(UIImage(named: "ic_show_password"), for: .normal)
        }
        eyeButton.addTarget(self, action: #selector(clearClicked(sender:)), for: .touchUpInside)

        rightView = eyeButton
    }
    
    func showIconRight(image: UIImage, mode: ViewMode) {
        clearButtonMode = .never
        rightViewMode   = mode
        
        let eyeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        eyeButton.setImage(image, for: .normal)
        
        rightView = eyeButton
    }
    
//    func setErrorWithText(_ errorString: String) {
//        self.text = nil
//        self.attributedPlaceholder = NSAttributedString(string: errorString,
//                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)])
//        if let image = UIImage(named: "icRequire") {
//            showIconRight(image: image, mode: .always)
//        }
//    }
    
//    func clearErrorWithPlaceHolder(_ text: String) {
//        self.placeholder = text
//        self.font = UIFont.sfProDisplayRegular(size: 15)
//        rightViewMode   = .whileEditing
//        if isSecureTextEntry == true {
//            showEyeButton()
//        }
//    }
//
    @objc func clearClicked(sender: UIButton) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        showEyeButton()
    }
    
    func setHighlightWhenEndEditting() {
        self.textColor = UIColor(hexString: "414042")
        self.font = UIFont.customFont(.bold, size: 15)
    }

    func setHighlightWhenEndEditting(hexColor color: String) {
        self.textColor = UIColor(hexString: color)
        self.font = UIFont.customFont(.bold, size: 15)
    }

    func setHighlightWhenEditting(_ color: UIColor? = nil) {
        if let color = color {
            self.textColor = color
        } else {
            self.textColor = UIColor(hexString: "4a4a4a")
        }

        self.font = UIFont.customFont(.bold, size: 15)
    }

    func setNormal() {
        self.textColor = UIColor(hexString: "4a4a4a")
        self.font = UIFont.customFont(.regular, size: 15)
    }

    func setNormalColor(_ color: String) {
        self.textColor = UIColor(hexString: color)
        self.font = UIFont.customFont(.regular, size: 15)
    }

    func setPlaceHolder(_ value: String) {
        self.placeholder = value
    }
}

//extension UITextView {
//    func setHighlightWhenEndEditting() {
//        self.textColor = UIColor(hexString: "414042")
//        self.font = UIFont.sfProDisplayBold(size: 15)
//    }
//    
//    func setHighlightWhenEditting() {
//        self.textColor = UIColor(hexString: "4a4a4a")
//        self.font = UIFont.sfProDisplayBold(size: 15)
//    }
//    
//    func setNormal() {
//        self.textColor = UIColor(hexString: "4a4a4a")
//        self.font = UIFont.sfProDisplayRegular(size: 15)
//    }
//    
//    func setHighlightWhenEditting(_ color: UIColor? = nil) {
//        if let color = color {
//            self.textColor = color
//        } else {
//            self.textColor = UIColor(hexString: "4a4a4a")
//        }
//        
//        self.font = UIFont.sfProDisplayBold(size: 15)
//    }
//    
//    func setPlaceholder(_ placeHoder: String,_ alignment: NSTextAlignment) {
//        let placeholderLabel = UILabel()
//        placeholderLabel.text = placeHoder
//        placeholderLabel.font = UIFont.systemFont(ofSize: (self.font?.pointSize)!)
//        placeholderLabel.tag = 222
//        placeholderLabel.frame = CGRect(x: 10, y: 0, width: self.width, height: 30)
//        placeholderLabel.textColor = UIColor.lightGray
//        placeholderLabel.isHidden = !self.text.isEmpty
//        placeholderLabel.textAlignment = alignment
//        self.addSubview(placeholderLabel)
//    }
//    
//    func checkPlaceholder() {
//        let placeholderLabel = self.viewWithTag(222) as! UILabel
//        placeholderLabel.isHidden = !self.text.isEmpty
//    }
//}
