//
//  MCConfirmQRVC.swift
//  MerchantApp
//
//  Created by Tien Anh Tran Duc on 03/11/2022.
//

import UIKit

final class EmptyDataView: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    var onAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generalInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        generalInit()
    }
    
    private func generalInit() {
        Bundle.main.loadNibNamed(EmptyDataView.identify, owner: self, options: nil)
        addSubview(contentView)
        contentView.fixInView(self)
    }
    
    func setupContent( title: String, image: UIImage? = nil){
        if let image = image {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "ic_empty_data")
        }
        titleLbl.text = title
        self.layoutIfNeeded()
    }

}
