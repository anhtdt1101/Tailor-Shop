//
//  TextField.swift
//  TranDucThang
//
//  Created by Tran Duc Tien Anh on 11/05/2023.
//

import Foundation
import UIKit

enum TFType{
    case phone
    case amount
    case content
    case none
}

class TextField: UITextField{
    @IBOutlet var errorLbl:UILabel?
    @IBOutlet weak var tfDelegate:UITextFieldDelegate?

    /**Max length of textfiled*/
    var maxLength: Int = 200
    
    /**Msg alert when validate textfield is empty*/
    var msgEmpty: String?
    
    /**Valid character when typing*/
    var validChars: String?
    
    /**Has value After call validate*/
    var msgError: String = ""{
        didSet{
            if let lbl = errorLbl{
                lbl.text = msgError
            }
        }
    }
    
    override var font: UIFont? {
        didSet {
            setupPlaceholder()
        }
    }
    
    var type:TFType = .none {
        didSet{
            setType()
        }
    }
    
    //MARK: Place holder
    override var placeholder: String? {
        didSet {
            setupPlaceholder()
        }
    }
    var placeHolderColor:UIColor = .gray {
        didSet {
            setupPlaceholder()
        }
    }
    
    var onEdittingChanged:((TextField)->Void)? {
        didSet {
            addEditingChanged()
        }
    }
    var onDidEndEditing:((TextField)->Void)?
    var onDidBeginEditing:((TextField)->Void)?
    var onShouldChanged:((TextField,NSRange,String,String)->Bool)?

    ///callback when click to return
    var onShouldReturn:((TextField)->Bool)?
    
    override var text: String? {
        didSet {
            if type == .amount {
                let text = text ?? ""
                let sText = text.removeCcy()
                if sText.isEmpty || sText.double == 0 {
                    super.text = ""
                } else {
                    super.text = sText.ccyFormat()
                }
            }
        }
    }
    var amount:String {
        let text = self.text ?? ""
        if type == .amount {
            let amount = text.removeCcy()
            return amount
        }
        return text
    }
    
    private var validations: [TFValidation] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.textColor = .black
    }
    
    func validate() -> Bool {
        let text = self.text ?? ""
        if text.count == 0 {
            if let msgEmpty = msgEmpty {
                self.msgError = msgEmpty
            }
            return false
        }

        if validations.count > 0 && text.notEmpty {
            for vld in validations {
                if vld.validate(self) == false {
                    self.msgError = vld.msg
                    return false
                }
            }
        }
        return true
    }
    
    func setupPlaceholder(){
        if let placeholder = placeholder{
            let font = self.font ?? .systemFont(ofSize: 14)
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor, NSAttributedString.Key.font: font])
        }
    }
    
    //MARK: Validation
    /**Add validate with msg and block*/
    func addValidate(_ msg: String,_ block:@escaping ((UITextField) -> Bool)) {
        validations.append(.init(msg, block))
    }
    
    /**Add validate with msg and regex pattern*/
    func addValidate(_ msg: String,_ pattern: String) {
        validations.append(.init(msg, pattern))
    }
    
    private func setType() {
        if type == .none {
            return
        }
        switch(type) {
        case .content:
            self.maxLength = 500
            self.msgEmpty = "Vui lòng nhâp nội dung này"
            break
        case .phone:
            self.maxLength = 10
            self.validChars = "^[0-9]{0,10}$"
            self.msgEmpty = "Vui lòng nhập số điện thoại"
            self.keyboardType = .numberPad
            break
        case .amount:
            self.maxLength = 11
            self.keyboardType = .numberPad
            self.validChars = "^[0-9]{0,20}$"
            break
        case .none:
            break
        }
    }
}

extension TextField: UITextFieldDelegate{
    func addEditingChanged() {
        addTarget(self, action: #selector(_editingChanged), for: .editingChanged)
    }
    
    @objc private func _editingChanged() {
        if let cb = onEdittingChanged {
            cb(self)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return tfDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        tfDelegate?.textFieldDidBeginEditing?(textField)
        onDidBeginEditing?(self)
        self.msgError = ""
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return tfDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        tfDelegate?.textFieldDidEndEditing?(textField)
        if let callBack = onDidEndEditing {
            callBack(self)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        tfDelegate?.textFieldDidEndEditing?(textField, reason:reason)
        if let callBack = onDidEndEditing {
            callBack(self)
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        onEdittingChanged?(self)
        return tfDelegate?.textFieldShouldClear?(textField) ?? true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let onShouldReturn = onShouldReturn {
            return onShouldReturn(self)
        }
        return tfDelegate?.textFieldShouldReturn?(textField) ?? true
    }
    
    //MARK: delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let validChars = validChars, validChars.notEmpty, string.count > 0 {
            let isValid = string.matchWith(pattern: validChars)
            if !isValid {
                return false
            }
        }
        guard let textFieldText = textField.text, let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        if count > maxLength {
            return false
        }
        
        if let tfDelegate = tfDelegate, tfDelegate.responds(to: #selector(textField(_:shouldChangeCharactersIn:replacementString:))) {
            let flag = tfDelegate.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
            return flag
        }
        
        return true
    }
}

private class TFValidation {
    var msg: String = ""
    var pattern: String?
    var callBack: ((UITextField) -> Bool)?
    
    init(_ msg: String,_ callBack: (@escaping (UITextField) -> Bool)) {
        self.msg = msg
        self.callBack = callBack
    }
    
    init(_ msg: String,_ pattern: String){
        self.msg = msg
        self.pattern = pattern
    }
    
    func validate(_ tf: TextField) -> Bool{
        let text = tf.text ?? ""
        if let pattern = pattern{
            return text.matchWith(pattern: pattern)
        } else if let callBack = callBack{
            return callBack(tf)
        }
        return true
    }
}
