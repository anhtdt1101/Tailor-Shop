//
//  ProductsCell.swift
//  TranDucThang
//
//  Created by Tien Anh Tran Duc on 19/08/2022.
//

import UIKit
//
//class ProductsCell: STableViewCell {
//    
//    @IBOutlet weak var statusLbl: UILabel!
//    @IBOutlet weak var pickupDateLbl: UILabel!
//    @IBOutlet weak var createDateLbl: UILabel!
//    @IBOutlet weak var typeLbl: UILabel!
//    @IBOutlet weak var depositLbl: UILabel!
//    @IBOutlet weak var priceLbl: UILabel!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    
//    override func setData(_ data: Any) {
//        if let data = data as? ProductModel{
//            var type = ""
//            if data.product == 0 {
//                type = "Áo Sơ Mi"
//            } else if data.product == 1{
//                type = "Quần"
//            } else if data.product == 2{
//                type = "Áo Vest"
//            }
//            typeLbl.text = type
//            let status = Int(data.status)
//            statusLbl.text = (status == 0) ? "Chưa lấy" : "Đã lấy"
//            statusLbl.textColor = (status == 0) ? .red : .green
//            pickupDateLbl.text = "Ngày lấy \(data.pickUpDate)"
//            createDateLbl.text = "Ngày tạo \(data.dateCreated.stringWithFormat("dd/MM/yyyy"))"
//            depositLbl.text = "Đã đặt \(Double(data.deposit)?.toCurrecyFormat() ?? "") VND"
//            priceLbl.text = "Giá tiền \(Double(data.price)?.toCurrecyFormat() ?? "") VND"
//        }
//    }
//    
//}
