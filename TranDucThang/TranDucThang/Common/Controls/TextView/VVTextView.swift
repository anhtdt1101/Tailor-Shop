//
//  VVTextView.swift
//  VVBASE
//
//  Created by Anh Nguyen on 15/07/2022.
//

import UIKit
@IBDesignable class VVTextView: UITextView {
    private var labelPlaceholder : UILabel?
    private var clearButton: VVButton?
    @IBInspectable var placeholderText: String = "" {
        didSet {
            labelPlaceholder?.text = placeholderText
        }
    }
    @IBInspectable var placeholderTextColor: UIColor = .cPlaceHolder
    
    override var text: String! {
        didSet {
            floatPlaceHolder()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addFloatingLabel()
        self.delegate = self
        self.textContainerInset = UIEdgeInsets(top: 22, left: 7, bottom: 8, right: 7)
        self.isScrollEnabled = false
        self.layer.borderColor = UIColor.cLoading.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.floatPlaceHolder()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        floatPlaceHolder()
    }
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        // If the current text is the placeholder, remove it
        floatPlaceHolder()
        addClearButton()
        layer.borderColor = UIColor.cLoading.cgColor
        return super.becomeFirstResponder()
    }
    @discardableResult
    override func resignFirstResponder() -> Bool {
        // If there's no text, put the placeholder back
        floatPlaceHolder()
        removeClearButton()
        return super.resignFirstResponder()
    }
    
    func floatPlaceHolder() -> Void {
        if self.isFirstResponder {
            floatDown()
        } else {
            if text.isEmpty {
                floatUp()
            } else {
                floatDown()
            }
        }
    }
    
    private func floatUp() {
        labelPlaceholder?.textColor = placeholderTextColor
        labelPlaceholder?.font = .regular(15)
        UIView.animate(withDuration: Double(0.3)) { [weak self] in
            self?.labelPlaceholder?.cPaddingTop?.constant = 15
            self?.layoutIfNeeded()
        }
    }
    
    private func floatDown() {
        labelPlaceholder?.textColor = .cPlaceHolder
        labelPlaceholder?.font = .regular(13)
        UIView.animate(withDuration: Double(0.3)) { [weak self] in
            self?.labelPlaceholder?.cPaddingTop?.constant = 6
            self?.layoutIfNeeded()
        }
    }
    
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
    
    func showError() {
        self.layer.borderColor = UIColor.cRed.cgColor
    }
    
    func addFloatingLabel() {
        labelPlaceholder = UILabel()
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeholderTextColor
        labelPlaceholder?.font = .regular(15)
        labelPlaceholder?.sizeToFit()
        labelPlaceholder?.translatesAutoresizingMaskIntoConstraints = false
        if let labelPlaceholder = labelPlaceholder {
            self.addSubview(labelPlaceholder)
            labelPlaceholder.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().offset(12)
                make.top.equalToSuperview().offset(18)
            }
        }
    }
    
    func addClearButton() {
        clearButton = VVButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        clearButton?.addTarget(self, action: #selector(onSelectClear), for: .touchUpInside)
        clearButton?.setImage(UIImage(named: "icTextFieldClear"), for: .normal)
        clearButton?.setTitle(nil, for: .normal)
        if let clearButton = clearButton {
            self.addSubview(clearButton)
            clearButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(0)
                make.top.equalToSuperview().offset(18)
                make.width.equalTo(36)
                make.height.equalTo(36)
            }
        }
    }
    
    func removeClearButton() {
        clearButton?.removeFromSuperview()
    }
    
    @objc func onSelectClear() {
        text = ""
    }
}

extension VVTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.layer.borderColor = UIColor.cLoading.cgColor
        floatPlaceHolder()
        addClearButton()
    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        floatPlaceHolder()
//        removeClearButton()
//    }
//    
//    func textViewDidChange(_ textView: UITextView) {
//          let fixedWidth = textView.frame.size.width
//          textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//          let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//          var newFrame = textView.frame
//          newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//          textView.frame = newFrame
//        self.layoutIfNeeded()
//    }
}
