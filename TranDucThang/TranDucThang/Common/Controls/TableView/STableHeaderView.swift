//
//  STableHeaderView.swift
//  IOSBase
//
//  Created by Tran Duc Tien Anh on 08/05/2023.
//

import Foundation
import UIKit

class STableHeaderView : UITableViewHeaderFooterView {
    
    @IBOutlet var titleLbl:UILabel?
    var section: Int = 0
    func drawSection(_ sec: STableSection, _ section:Int) {
        // must be override
        titleLbl?.text = sec.title
    }
}

