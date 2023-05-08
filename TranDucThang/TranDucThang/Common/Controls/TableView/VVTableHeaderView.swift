//
//  VVTableHeaderView.swift
//  VVBASE
//
//  Created by ChungNV MacProM1 on 16/06/2022.
//

import Foundation
import UIKit

class VVTableHeaderView : UITableViewHeaderFooterView {
    
    @IBOutlet var vLblTitle:UILabel?
    func drawSection(_ sec:VVTableSection, _ section:Int) {
        // must be override
        vLblTitle?.text = sec.title
    }
}
