//
//  VVTableViewCell.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 10/05/2022.
//

import Foundation
import UIKit

protocol VVTableViewCellDelegate: AnyObject {
    //nothing
    
}

class VVTableViewCell: UITableViewCell {
    var indexPath: IndexPath!
    weak var delegate: VVTableViewCellDelegate?
    var data: Any? {
        didSet {
            if let data = data {
                setData(data,indexPath)
            }
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    /** override if isAuto = false. Return height of cell */
    class func heightOf(_ data:Any) -> CGFloat {
        return 44.0
    }
    
    func setData(_ data:Any) {
//        print("\(self).setData:Must be override")
    }
    /**override me if u need to check indexpath of cell**/
    func setData(_ data:Any,_ idx:IndexPath) {
        // if u dont override me, call setData only
        setData(data)
    }
}

