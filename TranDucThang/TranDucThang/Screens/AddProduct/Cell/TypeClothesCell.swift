//
//  VVServiceBillSelectionCell.swift
//  VVBASE
//
//  Created by Tien Anh Tran Duc on 11/08/2022.
//

import UIKit

class TypeClothesCell: STableViewCell {
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var serviceLbl: VVLabel!
    
    var isChecked: Bool = false {
        didSet {
            checkImg.isHighlighted = isChecked
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setData(_ data: Any) {
        if let data = data as? TypeProduct{
            serviceLbl.text = data.title
        }
    }
}
