//
//  MCTextView.swift
//  IOSBase
//
//  Created by Tien Anh Tran Duc on 01/11/2022.
//

import Foundation
import UIKit
class TextView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var placeHolderLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    var flag = false
    @IBInspectable var nonUTF:Bool = false
    @IBInspectable var placeHolder: String? {
        didSet {
            guard flag else {
                return
            }
            placeHolderLbl.text = placeHolder
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            guard flag else {
                return
            }
            placeHolderLbl.textColor = placeHolderColor
        }
    }
    
    @IBInspectable var textColor: UIColor? {
        didSet {
            guard flag else {
                return
            }
            textView.textColor = textColor
        }
    }
    
    @IBInspectable var textFont: UIFont? {
        didSet {
            guard flag else {
                return
            }
            textView.font = textFont
        }
    }
    
    var onEditingChange: ((UITextView)->Void)?
    var maxLength: Int = 256
    
    var text: String = "" {
        didSet{
            guard flag else {
                return
            }
            placeHolderLbl.isHidden = !text.isEmpty
            textView.text = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Bundle.main.loadNibNamed(TextView.identify, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        flag = true
    }
}

extension TextView : UITextViewDelegate {
    func replaceViToEn(_ str: String) -> String {
        var vn = str.replacingOccurrences(of: "đ", with: "d")
        vn = vn.replacingOccurrences(of: "Đ", with: "D")
        guard let data = vn.data(using: .ascii, allowLossyConversion: true) else {
            return str
        }
        let en = String(data: data, encoding: .ascii) ?? str
        return en
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if nonUTF {
            let newText = textView.text ?? ""
            text = replaceViToEn(newText)
        } else {
            text = textView.text
        }
        onEditingChange?(textView)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < maxLength + 1    // 10 Limit Value
    }
}
