//
//  ClientCell.swift
//  BaBa Manager
//
//  Created by Tien Anh Tran Duc on 18/08/2022.
//

import UIKit

class ClientCell: STableViewCell {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setData(_ data: Any) {
        if let data = data as? ClientModel{
            nameLbl.text = data.fullName
            var phoneText = ""
            data.phoneNumber.forEach { phone in
                phoneText.append("\(phone) \n")
            }
            phoneLbl.text = phoneText
            addressLbl.text = data.addDress
        }
    }
    
}
