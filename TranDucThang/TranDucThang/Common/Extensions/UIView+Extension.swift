//
//  UIView+VV.swift
//  MerchantApp
//
//  Created by Tran Duc Tien Anh on 08/05/2023.
//

import Foundation
import UIKit


extension UIView {
    static var identify: String {
        get {
            return String(describing: self)
        }
    }
    class func fromNib() -> Self {
        if let first = Bundle.main.loadNibNamed(identify, owner: nil, options: nil)?.first {
            if let view = first as? Self {
                return view
            }
        }
        return Self.init(frame: CGRect.zero)
    }
    
    func className() -> String {
        let clsName = String(describing: type(of: self))
        return clsName
    }
    
    class func appWindow() -> UIWindow? {
        if let appDelegate = UIApplication.shared.delegate {
            if let wd = appDelegate.window as? UIWindow {
                return wd
            }
        }
        
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            for newWindow in windowArray {
                if newWindow.windowLevel == UIWindow.Level.normal {
                    window = newWindow
                    break
                }
            }
        }
        return window
    }
    //MARK: Contraint
    private func findLCWH(_ att: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        var cLow:NSLayoutConstraint?
        for lc in self.constraints {
            let firstItem = lc.firstItem
            if let vFirst = firstItem as? UIView,vFirst == self {
                if lc.firstAttribute == att {
                    if lc.priority == .defaultHigh {
                        return lc
                    }else {
                        cLow = lc
                    }
                }
            }
        }
        return cLow
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    var cHeight: NSLayoutConstraint? {
        get { return findLCWH(.height) }
    }
    
    var cWidth: NSLayoutConstraint? {
        get { return findLCWH(.width) }
    }
    
    var cPaddingTop: NSLayoutConstraint? {
        get { return findLCPadding(.top) }
    }
    
    var cPaddingLeft: NSLayoutConstraint? {
        get { return findLCPadding(.leading) }
    }
    
    var cPaddingRight: NSLayoutConstraint? {
        get { return findLCPadding(.trailing) }
    }
    
    var cPaddingBottom: NSLayoutConstraint? {
        get { return findLCPadding(.bottom) }
    }
    
    private func isSupOrBrother(_ view: AnyObject?) -> Bool {
        if view == nil {
            return false
        }
        if let _ = view as? UILayoutGuide {
            return true
        }
        if let vSup = self.superview, let view = view as? UIView {
            if view == vSup {
                return true
            }
            if view.superview == vSup {
                return true
            }
        }
        return false
    }
    
    private func findLCPadding(_ att: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let vSuper = self.superview {
            for lc in vSuper.constraints {
                
                if att == .bottom ||
                    att == .trailing {
                    // second = self
                    // first = sup or the same self.sup
                    if lc.secondAttribute != att {
                        continue
                    }
                    if let vSecond = lc.secondItem as? UIView, vSecond == self {
                        if isSupOrBrother(lc.firstItem) {
                            return lc
                        }
                    }
                }else {
                    //first = self
                    //second == sup or second.sup = self.sup
                    if (lc.firstAttribute != att) {
                        continue;
                    }
                    if let vFirst = lc.firstItem as? UIView, vFirst == self {
                        if isSupOrBrother(lc.secondItem) {
                            return lc
                        }
                    }
                }
            }
        }
        return nil
    }
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var wdSafeAreaInsets: UIEdgeInsets {
        if let wd = UIView.appWindow() {
            if #available(iOS 11.0, *) {
                return wd.safeAreaInsets
            }
        }
        return .zero
    }
    
    func topSafeAreaHeight() -> CGFloat{
        guard let root = UIApplication.shared.keyWindow?.rootViewController else { return 0 }
        if #available(iOS 11.0, *) {
            return root.view.safeAreaInsets.top
        } else {
            return root.topLayoutGuide.length
            // Fallback on earlier versions
        }
    }
        
    //MARK: Other
    func fixInView(_ container: UIView!) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func removeAllSubviews() {
        for sView in self.subviews {
            sView.removeFromSuperview()
        }
    }
    
    func image() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    
    func removeLayerWithName(_ name: String) {
        if let layers = self.layer.sublayers {
            for layer in layers {
                if layer.name == name {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    func addHorizontalDashLine(_ width: CGFloat, lenght: CGFloat, space: CGFloat, color: UIColor) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color.cgColor
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [lenght, space] as [NSNumber]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: self.frame.height)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
    
    func addVerticalDashLine(_ width: CGFloat, lenght: CGFloat, space: CGFloat, color: UIColor) {
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color.cgColor
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [lenght, space] as [NSNumber]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
    }
    
    func roundTopCorner(_ radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.clipsToBounds = true
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            self.roundCorners([.topLeft, .topRight], radius: radius)
        }
    }
    
    func roundBottomCorner(_ radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.clipsToBounds = true
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            self.roundCorners([.topLeft, .topRight], radius: radius)
        }
    }
    
    func rotateAnimation(aCircleTime: Double) { //CABasicAnimation
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = -Double.pi * 2 //Minus can be Direction
        rotationAnimation.duration = aCircleTime
        rotationAnimation.repeatCount = .infinity
        self.layer.add(rotationAnimation, forKey: nil)
    }
    
    func removeRotateAnimation() {
        self.layer.removeAllAnimations()
    }
    
    func setupTriangleView() {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: self.bounds.maxY))
        path.addLine(to: CGPoint(x: self.bounds.midX, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.maxY))
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.hex("ebf4ff").cgColor
        shape.opacity = 0.8
        self.layer.insertSublayer(shape, at: 0)
    }
    
}

extension UIStackView {

    func safelyRemoveArrangedSubviews() {
        // Remove all the arranged subviews and save them to an array
        let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }
        // Deactive all constraints at once
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func addBackground(color: UIColor) {
        let subview = UIView(frame: bounds)
        subview.backgroundColor = color
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subview, at: 0)
    }
}
//MARK: For xib
extension UIView {
    @IBInspectable var vvCornerAHalf:Bool {
        get {
            return false
        }
        set{
            self.vvRadius = self.height/2.0
        }
    }
    @IBInspectable var vvRadius:CGFloat {
        get {
            return 0
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var vvBorderWidth:CGFloat {
        get {
            return 0
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var vvBorderColor:UIColor? {
        get {
            return nil
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var vvShadow:Bool {
        set {
            if newValue {
                self.layer.masksToBounds = false
                self.layer.shadowColor = UIColor.cBlack.cgColor
                self.layer.shadowOffset = .vvSize(0, 2)
                self.layer.shadowRadius = 11
                self.layer.shadowOpacity = 0.1
            }else {
                self.layer.shadowColor = UIColor.clear.cgColor
                self.layer.masksToBounds = true
            }
        }
        get {
            return false
        }
    }
}

