//
//  DetailsInputCell.swift
//  VVBASE
//
//  Created by Tien Anh Tran Duc on 11/07/2022.
//

import UIKit

struct DetailCellModel {
    var title: String
    var value: String
    var typeTextField : VVTFType
    var isValidate: Bool = false
    var isNote: Bool = false
    var errorTF: String = ""
    var isTextView: Bool = false
    var onTextF: ((String) -> Void)?
    var onTextView: ((String) -> Void)?
    var isEnable: Bool = true
}

class DetailsInputCell: STableViewCell {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: DyniamicTF!
    
    var dataModel: DetailCellModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setData(_ data: Any) {
        if let data = data as? DetailCellModel{
            bindingData(data)
        }
    }
    
    override class func heightOf(_ data: Any) -> CGFloat {
        return 80
    }
    
    func bindingData(_ data: DetailCellModel) {
        self.dataModel = data
        if data.isTextView {
            textField.isHidden = true
            textView.isHidden = false
        } else {
            textField.isHidden = false
            textView.isHidden = true
            textField.title = data.title
            textField.type = data.typeTextField
            textField.text = data.value
            textField.tf.isEnabled = data.isEnable
            textField.tf.onEdittingChanged = { [weak self] tf in
                if tf.text?.isEmpty == true && data.isValidate{
                    self?.textField.error = data.errorTF
                } else {
                    self?.textField.error = ""
                }
                if data.typeTextField == .amount{
                    data.onTextF?(self?.textField.tf.amount ?? "")
                } else {
                    data.onTextF?(tf.text ?? "")
                }
            }
        }
    }
    
}

extension DetailsInputCell: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            self.dataModel.onTextView?(text)
        }
    }
}
