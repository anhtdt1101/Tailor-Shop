//
//  SCollectionViewCell.swift
//  IOSBase
//
//  Created by Tran Duc Tien Anh on 08/05/2023.
//

import Foundation
import UIKit

protocol SCollectionViewCellDelegate: AnyObject {
    //nothing
}

class SCollectionViewCell: UICollectionViewCell{
    
    weak var delegate: SCollectionViewCellDelegate?
    var indexPath: IndexPath?
    var data: Any? {
        didSet{
            if let data = data{
                setData(data)
            }
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // for override to setup content
    func setData(_ data: Any){
        
    }
    // override for set custom size for each cell
    class func sizeWithData(_ data: Any,_ indexPath: IndexPath,_ allData: [Any]) -> CGSize? {
        return sizeWithData(data)
    }
    
    class func sizeWithData(_ data:Any) -> CGSize? {
        return nil
    }
}
