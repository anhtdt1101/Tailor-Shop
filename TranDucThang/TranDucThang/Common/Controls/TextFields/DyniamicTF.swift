//
//  DyniamicTF.swift
//  VVBASE
//
//  Created by Tien Anh Tran Duc on 18/08/2022.
//

import Foundation
import UIKit

typealias VVVoidBlock = (() -> Void)
typealias VVBoolBlock = ((Bool) -> Void)

class DyniamicTF : UIView {
    /**Padding left*/
    var pLeft:CGFloat = 12
    /**Padding right*/
    var pRight:CGFloat = 12
    
    @IBOutlet private var vMain:UIView!
    @IBOutlet private var vRect:UIView!
    @IBOutlet var vLeft:UIView!
    @IBOutlet var vRight:UIView!
    @IBOutlet var tf:VVTextField!
    @IBOutlet var vBtnClear:UIButton!
    
    @IBOutlet private var lblTitle:UILabel!
    @IBOutlet private var lblNote:UILabel!
    @IBOutlet private var lblError:UILabel!
    
    var onClickItem: (() -> Void)?
    var didEndEditing: ((String) -> Void)?
    /**Title when floated**/
    @IBInspectable var floatTitle:String?
    @IBInspectable var title:String = "" {
        didSet {
            if lblTitle.superview != nil {
                lblTitle.text = title
                onTextChanged()
            }
        }
    }
    @IBInspectable var hint:String = "" {
        didSet {
            if tf.superview != nil {
                tf.placeholder = hint
                onTextChanged()
            }
        }
    }
    var error:String = "" {
        didSet {
            lblError.text = error
            onError(error.notEmpty)
        }
    }
    var note:String = "" {
        didSet {
            noteLayout()
        }
    }
    var text: String? {
        get {
            return tf.text
        }
        set {
            tf.text = newValue
            onTextChanged()
        }
    }
    var keyboardType: UIKeyboardType = .default {
        didSet {
            tf.keyboardType = keyboardType
        }
    }
    var maxLegnth: Int = 100 {
        didSet {
            tf.maxLength = maxLegnth
        }
    }
    var type: VVTFType = .none {
        didSet {
            tf.type = type
        }
    }
    private var itemButton: UIButton?
    @IBInspectable var styleSelect: Bool = false {
        didSet {
            selectionLayout()
        }
    }
    
    private var vImgLeft:UIImageView?
    @IBInspectable var leftIcon:UIImage? {
        didSet {
            leftLayout()
        }
    }
    private var vImgRight:UIImageView?
    var vBtnRight:UIButton?
    var onRightAction:VVVoidBlock? {
        didSet {
            vBtnRight?.touchUpinSide = onRightAction
        }
    }
    private var vBtnDrop:UIButton?
    var onDropAction:VVVoidBlock? {
        didSet {
            if vBtnDrop == nil {
                vBtnDrop = UIButton()
                addSubview(vBtnDrop!)
                vBtnDrop?.snp4Sides()
            }
            vBtnDrop?.touchUpinSide = onDropAction
        }
    }
    @IBInspectable var rightIcon:UIImage? {
        didSet {
            rightLayout()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        vvInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        vvInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        if let cnt = self.cHeight {
            cnt.priority = .defaultLow
        }else {
            NSLog("\(Self.self).\(#function):not found cHeight")
        }
        vMain.snp4Sides()
        onTextChanged()
        
    }
    private func vvInit() {
        Bundle.main.loadNibNamed("VVTextFieldFloat", owner: self, options: nil)
        addSubview(vMain)
        tf.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
        tf.tfDelegate = self
        
        vBtnClear.addTarget(self, action: #selector(onClear), for: .touchUpInside)
        
        //for testing layout
//        tf.backgroundColor = .yellow
//        lblTitle.backgroundColor = .blue
    }
    
    func getValue() -> String {
        if let text = tf.text {
            return text
        }
        return ""
    }
    
    @objc func onTextChanged() {
        if self.isHidden {
            return
        }
        var pY:CGFloat = 15
        var tY:CGFloat = 0
        var tH:CGFloat = 50
        var pFont:UIFont = .regular(15)
        var pColor:UIColor = .cGray
        
        let hasPlaceHolder = tf.placeholder?.notEmpty ?? false
        let hasText = tf.text?.notEmpty ?? false
        let title = self.title
        
        if hasText || hasPlaceHolder {
            //has text or placeholder
            pY = 6
            pFont = .regular(11)
            pColor = .cPlaceHolder
            
            let pH = lblTitle.text?.heightOfString(usingFont: pFont) ?? 0
            tY = ceil(pH) - 4
            tH = 50 - tY
        }
        if let floatTitle = floatTitle,floatTitle.notEmpty {
            if hasText && !hasPlaceHolder {
                lblTitle.text = floatTitle
            }else {
                lblTitle.text = title
            }
        }
        let animate = lblTitle.cPaddingTop?.constant != pY
        lblTitle.cPaddingTop?.constant = pY
        lblTitle.font = pFont
        lblTitle.textColor = pColor
        
        tf.cHeight?.constant = tH
        tf.cPaddingTop?.constant = tY
        
        if animate {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
        checkBtnClear()
    }
    @objc func onClear() {
        self.tf.text = ""
        onTextChanged()
        tf.sendActions(for: .editingChanged)
    }
    
    func validate() -> Bool {
        if tf.validate() == false {
            self.error = tf.msgError
            return false
        }
        return true
    }
    
    func makeHidden(_ flag:Bool = true) {
        if flag {
            self.isHidden = true
            lblTitle.text = ""
            lblNote.text = ""
            lblError.text = ""
            tf.cHeight?.constant = 0
        }else {
            self.title = "\(title)"
            self.note = "\(note)"
            self.isHidden = false
            onTextChanged()
        }
    }
    
    func setHeightItem(_ height: CGFloat) {
        if height == 0 {
            makeHidden()
        } else {
            self.isHidden = false
            tf.cHeight?.constant = height
        }
    }
}
extension DyniamicTF : UITextFieldDelegate {
    private func checkBtnClear() {
        let isEditting = tf.isFirstResponder
        //(on + có text) thì show btnclear
        if let text = tf.text, text.notEmpty, isEditting {
            vBtnClear.isHidden = false
        }else {
            vBtnClear.isHidden = true
        }
    }
    
   private func onError(_ on:Bool = true) {
        let isEditting = tf.isFirstResponder
        vRect.vvBorderColor = on ? .cRed : (isEditting ? .cBlue : .borderColor)
        
        lblError.cPaddingTop?.constant = error.notEmpty ? 6 : 0
    }
    private func onFocus(_ on:Bool = true) {
        vRect.vvBorderColor = on ? .cBlue : .cLoading
        checkBtnClear()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        error = ""
        onFocus()
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        didEndEditing?(textField.text ?? "")
        onFocus(false)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        didEndEditing?(textField.text ?? "")
        onFocus(false)
    }
}

extension DyniamicTF {
    override var canBecomeFirstResponder: Bool {
        return tf.canBecomeFirstResponder
    }
    override func becomeFirstResponder() -> Bool {
        return tf.becomeFirstResponder()
    }
    override func resignFirstResponder() -> Bool {
        return tf.resignFirstResponder()
    }
}

//MARK: NOTE + LEFT + RIGHT
extension DyniamicTF {
    @objc func didSelectItem() {
        onClickItem?()
    }
    
    func selectionLayout() {
        itemButton = UIButton()
        itemButton?.setTitle("", for: .normal)
        itemButton?.addTarget(self, action: #selector(didSelectItem), for: .touchUpInside)
        if itemButton?.superview == nil {
            addSubview(itemButton!)
            itemButton?.snp.makeConstraints({ make in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.bottom.equalToSuperview()
                make.right.equalToSuperview()
            })
        }
    }
    
    func noteLayout() {
        lblNote.text = note
        lblNote.cPaddingBottom?.constant = note.notEmpty ? 6 : 0
        lblNote.cPaddingTop?.constant = note.notEmpty ? -6 : 0
    }
    func leftLayout() {
        if let leftIcon = leftIcon {
            if let vImgLeft = vImgLeft {
                vImgLeft.image = leftIcon
            }else {
                vImgLeft = .vvImageOf(leftIcon)
            }

            if vImgLeft?.superview == nil {
                vLeft.addSubview(vImgLeft!)
            }
            vImgLeft?.frame = .init(x: pLeft, y: 0, width: leftIcon.size.width, height: vLeft.height)
            vLeft.cWidth?.constant = vImgLeft!.xRight + 8
            vLeft.isHidden = false
        }else {
            vImgLeft?.removeFromSuperview()
            vLeft.cWidth?.constant = pLeft
            vLeft.isHidden = true
        }
        onTextChanged()
    }
    
    func rightLayout() {
        if let rightIcon = rightIcon {
            if let vImgRight = vImgRight {
                vImgRight.image = rightIcon
            }else {
                vImgRight = .vvImageOf(rightIcon)
            }
            if vImgRight?.superview == nil {
                vRight.addSubview(vImgRight!)
            }
            vImgRight?.frame = .init(x: 8, y: 0, width: rightIcon.size.width, height: vRight.height)
            let width = vImgRight!.xRight + pRight
            vRight.cWidth?.constant = width
            vRight.isHidden = false
            
            if vBtnRight == nil {
                vBtnRight = UIButton.init(frame: .init(x: 0, y: 0, width: width, height: vRight.height))
                vRight.addSubview(vBtnRight!)
            }
            vRight.bringSubviewToFront(vBtnRight!)
        }else {
            vImgRight?.removeFromSuperview()
            vRect.cWidth?.constant = pRight
            vRect.isHidden = true
        }
        onTextChanged()
    }
}

extension UIImageView {
    class func vvImageOf(_ img:UIImage) -> UIImageView {
        let vImg = UIImageView.init(frame: CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height))
        vImg.image = img
        vImg.contentMode = .center
        return vImg
    }
}
