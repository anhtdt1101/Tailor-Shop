//
//  VVTextFieldValidate.swift
//  VVBASE
//
//  Created by Tien Anh Tran Duc on 18/08/2022.
//

import Foundation
import UIKit

enum VVTFType {
    case username
    case password
    case content
    case name
    case email
    case phone
    case promotion
    
    /**auto format numeric with amount formating*/
    case amount
    case none
}

class VVTextField: UITextField {
    
    override var font: UIFont? {
        didSet {
            setPlaceHolderColorAtts()
        }
    }
    
    var type:VVTFType = .none {
        didSet{
            setType()
        }
    }
    
    /**Max length of textfiled*/
    var maxLength: Int = 200
    
    /**Msg alert when validate textfield is empty*/
    var msgEmpty: String?
    
    /**Valid character when typing*/
    var validChars: String?
    
    /**Has value After call validate*/
    var msgError: String = ""
    
    private var validations: [VVTFValidation] = []
    
    /**Delegate of textfield. Raise true delegate**/
    var tfDelegate:UITextFieldDelegate?
    var isAmount:Bool {
        return type == .amount
    }
    override var text: String? {
        didSet {
            if isAmount {
                let text = text ?? ""
                if text.isEmpty || text.double == 0 {
                    super.text = ""
                } else {
                    super.text = text.removeCcy().ccyFormat()
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
    
    var onEdittingChanged:((VVTextField)->Void)? {
        didSet {
            addEditingChanged()
        }
    }
    var onDidEndEditing:((VVTextField)->Void)?
    var onDidBeginEditing:((VVTextField)->Void)?
    
    //MARK: View
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.textColor = .cBlack
    }
    
    //MARK: Place holder
    override var placeholder: String? {
        didSet {
            setPlaceHolderColorAtts()
        }
    }
    var placeholderColor:UIColor = .cPlaceHolder {
        didSet {
            setPlaceHolderColorAtts()
        }
    }
    
    private func setPlaceHolderColorAtts() {
        guard let placeholder = placeholder else {
            return
        }
        guard let atts = attributedPlaceholder else {
            return
        }
        let attsHolder = NSMutableAttributedString(attributedString: atts)
        let font = self.font ?? .medium(15)
        let dAtt:[NSAttributedString.Key:Any] = [
            .foregroundColor : placeholderColor,
            .font             : font
        ]
        let range = NSRange(location: 0, length: placeholder.count)
        attsHolder.setAttributes(dAtt, range:range)
        
        self.attributedPlaceholder = attsHolder
    }
    
    //MARK: Validation
    /**Add validate with msg and block*/
    func addValidate(_ msg: String,_ block:@escaping VVTFValidationBlock) {
        validations.append(.init(msg, block))
    }
    
    /**Add validate with msg and regex pattern*/
    func addValidate(_ msg: String,_ pattern: String) {
        validations.append(.init(msg, pattern))
    }
    
    func validate() -> Bool {
        let text = self.text ?? ""
        if let msgEmpty = msgEmpty {
            if text.count == 0 {
                self.msgError = msgEmpty
                return false
            }
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
    
    //MARK: delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let isPaste = string.count > 1

        if type == .amount {
            return tfAmount(shouldChangeCharactersIn: range, replacementString: string)
        }
        if let validChars = validChars, string.count > 0 {
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
    
    private func setType() {
        if type == .none {
            return
        }
        switch(type) {
        case .promotion:
            self.maxLength = 20
            self.validChars = "^[a-zA-Z0-9]+$"
            self.msgEmpty = "tf.content.empty"
        case .username:
            self.maxLength = 20
            self.validChars = "^[0-9a-zA-Z]{0,20}$"
            self.msgEmpty = "Quý khách vui lòng nhập tên đăng nhập..."
            break
        case .password:
            self.maxLength = 20
//            self.validChars = "^[A-Za-z0-9\\s]"
            self.msgEmpty = "..."
            break
        case .content:
            self.maxLength = 200
            self.validChars = "^[0-9a-zA-Z\\s]{0,20}$"
            self.msgEmpty = "tf.content.empty"
            break
        case .name:
            self.maxLength = 200
            self.validChars = "^[0-9a-zA-Z\\s]{0,200}$"
            self.msgEmpty = "tf.name.empty"
            break
        case .email:
            self.maxLength = 200
//            self.validChars = "^[0-9a-zA-Z.]{0,20}$"
//            self.msgEmpty = "tf.email.empty"
            addValidate("tf.email.wrong", .kTfPatternEmail)
            break
        case .phone:
            self.maxLength = 10
            self.validChars = "^[0-9]{0,10}$"
            self.msgEmpty = "tf.phone.empty"
            self.keyboardType = .numberPad
            addValidate("tf.phone.wrong", .kTfPatternPhone)
            break
        case .amount:
            self.maxLength = 13
            self.keyboardType = .numberPad
            self.validChars = "^[0-9]{0,20}$"
            break
        case .none:
            break
        }
    }
    
    func tfAmount(shouldChangeCharactersIn  range: NSRange, replacementString rpString: String) -> Bool {
        var string = rpString
        let oldText = self.text ?? ""
        if string == "," || string == "." {
            string = ","
            if oldText == "0" {
                string = "0" + string
                super.text = string
                self.sendActions(for: .editingChanged)
                return false
            }
        }
        var rrange = range
        if string == "" {
            if let r = Range(rrange,in:oldText) {
                let strDelete = oldText[r]
                if strDelete == "." {
                    rrange.location -= 1
                }
            }
        }
        guard let textRange = Range(rrange, in: oldText) else {
                return false
        }
        if string != "" {
            let r = NSRange(location: 0, length: string.count)
            if let rr = Range(r, in: rpString) {
                //remove non-number character
                string = string.replacingOccurrences(of:"[^0-9]", with: "", options: .regularExpression, range:rr)
            }
        }
        var newText = oldText.replacingCharacters(in: textRange,with: string)
        newText = newText.replacingOccurrences(of: ".", with: "")
        if newText.count > self.maxLength {
            return false
        }

        if Double(newText) == 0 {
            super.text = "0"
            return false
        }
        newText = newText.ccyFormat()
        super.text = newText
        
        //set new cusor
        self.updateCusor(oldText, range)

        self.sendActions(for: .editingChanged)
        return false
    }
    

    /**Keep cusor postion dont changed*/
    private func updateCusor(_ oldText:String,_ range:NSRange) {
        let lastLength = oldText.count - range.location - range.length
        //set new cusor
        let newText = self.text ?? "0"
        var newPos = newText.count - lastLength
        newPos = max(0,newPos)
        
        if let newCusor = self.position(from: self.beginningOfDocument, offset: newPos) {
            let newTextRange = self.textRange(from: newCusor, to: newCusor)
            self.selectedTextRange = newTextRange
        }
    }
}

extension VVTextField : UITextFieldDelegate {
    
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
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return tfDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        tfDelegate?.textFieldDidEndEditing?(textField)
        if let block = onDidEndEditing {
            block(self)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        tfDelegate?.textFieldDidEndEditing?(textField, reason:reason)
        if let block = onDidEndEditing {
            block(self)
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return tfDelegate?.textFieldShouldClear?(textField) ?? true
    }
}

extension String {
    public static var kTfPatternPhone:String = "^(\\+84|0)[0-9]{9,10}$"
    
    public static var kTfPatternEmail:String = "^[0-9a-zA-Z.\\_]+@[a-zA-Z0-9]+(\\.[a-zA-Z]{2,4}){1,2}$"
}

typealias VVTFValidationBlock = (UITextField) -> (Bool)
private class VVTFValidation {
    var msg: String = ""
    var pattern: String?
    var block: VVTFValidationBlock?
    
    init(_ msg: String,_ block:@escaping VVTFValidationBlock) {
        self.msg = msg
        self.block = block
    }
    
    init(_ msg: String,_ pattern: String) {
        self.msg = msg
        self.pattern = pattern
    }
    
    func validate(_ tf: VVTextField) -> Bool {
        let text = tf.text ?? ""
        if let pattern = pattern {
            let flag = text.matchWith(pattern: pattern)
            return flag
            
        }else if let block = block {
            let flag = block(tf)
            return flag
        }
        return true
    }
}


extension String {
    func findBy(pattern:String) -> ([NSRange],[String])? {
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let matches = regex.matches(in: self, range: .init(location: 0, length: self.count))
        if matches.notEmpty {
            let ranges:[NSRange] = []
            var strings:[String] = []
            for m in matches {
                var sub = ""
                if let rr = Range(m.range,in:self) {
                    sub = String(self[rr])
                }
                strings.append(sub)
            }
            return (ranges,strings)
        }
        return nil
    }
    func replaceCharBy(pattern:String, _ other:String = "") -> String {
        let r = NSRange(location: 0, length: self.count)
        if let range = Range(r, in: self) {
            //remove non-number character
            let rslt = self.replacingOccurrences(of:"[^0-9]", with: other, options: .regularExpression, range:range)
            return rslt
        }
        return self
    }
    func replace(_ range:NSRange, with other:String) -> String{
        guard let textRange = Range(range, in: self) else {
            return self
        }
        let rslt = self.replacingCharacters(in: textRange, with:other)
        return rslt
    }
}
