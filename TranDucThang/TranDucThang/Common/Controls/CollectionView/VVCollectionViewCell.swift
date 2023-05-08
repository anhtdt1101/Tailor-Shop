//
//  VVCollectionViewCell.swift
//  VVBASE
//
//  Created by Anh Nguyen on 20/06/2022.
//

import UIKit

protocol VVCollectionViewCellDelegate: AnyObject {
    //nothing
}

class VVCollectionViewCell: UICollectionViewCell {
    weak var delegate: VVCollectionViewCellDelegate?
    var indexPath: IndexPath?
    var data: Any? {
        didSet {
            if let data = data {
                setData(data)
            }
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(_ data:Any) {
//        print("\(self).setData:Must be override")
    }
    class func sizeWithData(_ data:Any,_ idxPath:IndexPath,_ allData:[Any]) -> CGSize? {
        //default
        return sizeWithData(data)
    }
    
    class func sizeWithData(_ data:Any) -> CGSize? {
        return nil
    }
}
