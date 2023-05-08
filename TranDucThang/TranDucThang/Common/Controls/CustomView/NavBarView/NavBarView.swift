//
//  VVNavBarView.swift
//  VVBASE
//
//  Created by Anh Nguyen on 01/06/2022.
//

import UIKit

class NavBarView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet weak var right1Button: UIButton!
    @IBOutlet private weak var right2Button: UIButton!

    var onBackAction: (() -> Void)?
    var onRight1Action: (() -> Void)?
    var onRight2Action: (() -> Void)?
    // navbar trắng thì isStyleDefault = true
    var isStyleDefault: Bool = true {
        didSet {
            titleLabel.textColor = isStyleDefault ? UIColor.hex("333333") : .white
            let backImage = isStyleDefault ? UIImage(named: "ic_nav_back") : UIImage(named: "ic_back_white")
            backButton.setImage(backImage, for: .normal)
        }
    }
    var titleColor: UIColor = UIColor.hex("333333") {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var leftImage: UIImage? = nil {
        didSet {
            backButton.setImage(leftImage, for: .normal)
        }
    }
    var right1Image: UIImage? = nil {
        didSet {
            right1Button.setImage(right1Image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    var right1Title: String? = nil {
        didSet {
            right1Button.setTitle(right1Title, for: .normal)
            right1Button.contentHorizontalAlignment = .center
            if let string = right1Title {
                let widthString = string.widthOfString(usingFont: UIFont.customFont(.bold, size: 13))
                right1Button.cWidth?.constant = widthString + 30
            } else {
                right1Button.cWidth?.constant = 0
            }
        }
    }
    var right2Image: UIImage? = nil {
        didSet {
            right2Button.setImage(right2Image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    var right2Title: String? = nil {
        didSet {
            right2Button.setTitle(right2Title, for: .normal)
            right2Button.contentHorizontalAlignment = .center
            if let string = right2Title {
                let widthString = string.widthOfString(usingFont: UIFont.customFont(.bold, size: 13))
                right2Button.cWidth?.constant = widthString + 30
            } else {
                right2Button.cWidth?.constant = 0
            }
        }
    }
    
    var right1ButtonBorderColor: UIColor = .clear {
        didSet {
            right1Button.layer.borderWidth = 1
            right1Button.layer.borderColor = right1ButtonBorderColor.cgColor
        }
    }
    
    var isHiddenLeft: Bool = false {
        didSet {
            backButton.isHidden = isHiddenLeft
        }
    }
    // MARK: Views
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(NavBarView.identify, owner: self, options: nil)
        contentView.fixInView(self)
        self.cHeight?.priority = .defaultLow
        isStyleDefault = true
    }
    
    // MARK: @IBAction
    @IBAction func didSelectBack(_ sender: Any) {
        self.onBackAction?()
    }
    
    @IBAction func didSelectRight1(_ sender: Any) {
        self.onRight1Action?()
    }
    
    @IBAction func didSelectRight2(_ sender: Any) {
        self.onRight2Action?()
    }
}
