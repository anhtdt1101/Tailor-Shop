//
//  TextFieldBox.swift
//  TranDucThang
//
//  Created by Tran Duc Tien Anh on 11/05/2023.
//

import Foundation
import UIKit

class TextFieldBox: UIView {
    
    @IBOutlet weak var rectView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tf: TextField!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var dropBtn: UIButton!
    
    var didEndEditing: ((String) -> Void)?

    @IBInspectable var title:String = "" {
        didSet {
            if titleLbl.superview != nil {
                titleLbl.text = title
            }
        }
    }
    @IBInspectable var placeholder:String = "" {
        didSet {
            if tf.superview != nil {
                tf.placeholder = placeholder
            }
        }
    }
    
    @IBInspectable var rightImg:UIImage? {
        didSet{
            if rightImage.superview != nil{
                rightImage.image = rightImg
                rightImage.cWidth?.constant = 24
            } else{
                rightImage.cWidth?.constant = 0
            }
        }
    }
    
    var typeTextField: TFType = .none{
        didSet{
            if tf.superview != nil {
                tf.type = typeTextField
            }
        }
    }
    
    var error:String = "" {
        didSet {
            errorLbl.text = error
            onError(error.notEmpty)
        }
    }
    
    var onDropAction: (() -> Void)?{
        didSet{
            if let onDropAction = onDropAction{
                dropBtn.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _init()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let cnt = self.cHeight {
            self.removeConstraint(cnt)
        }else {
            NSLog("\(Self.self).\(#function):not found cHeight")
        }
    }
    
    private func _init() {
        Bundle.main.loadNibNamed("TextFieldBox", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        tf.tfDelegate = self
    }
    
    func getValue() -> String {
        if let text = tf.text {
            return text
        }
        return ""
    }
    
    func validate() -> Bool {
        if tf.validate() == false {
            self.error = tf.msgError
            return false
        }
        self.error = ""
        return true
    }
    
    func checkBtnClear() {
        let isEditting = tf.isFirstResponder
        //(on + có text) thì show btnclear
        if let text = tf.text, text.notEmpty, isEditting {
            clearBtn.isHidden = false
            clearBtn.cWidth?.constant = 40
        }else {
            clearBtn.isHidden = true
            clearBtn.cWidth?.constant = 0
        }
    }
    
    private func onError(_ on:Bool = true) {
         let isEditting = tf.isFirstResponder
         rectView.vvBorderColor = on ? .red : (isEditting ? .blue : .lightGray)
         errorLbl.cPaddingTop?.constant = error.notEmpty ? 6 : 0
     }
    
    private func onFocus(_ on:Bool = true) {
        rectView.vvBorderColor = on ? .blue : .clear
        checkBtnClear()
    }
    
    @IBAction func didSelectDrop(_ sender: Any) {
        onDropAction?()
    }
    
    @IBAction func didSelectClear(_ sender: Any) {
        self.tf.text = ""
        tf.sendActions(for: .editingChanged)
    }
}

extension TextFieldBox: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        error = ""
        onFocus()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didEndEditing?(textField.text ?? "")
        onFocus(false)
    }
}
