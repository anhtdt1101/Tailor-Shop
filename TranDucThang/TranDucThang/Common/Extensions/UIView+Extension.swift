//
//  UIView+VV.swift
//  MerchantApp
//
//  Created by ChungNV MacProM1 on 06/05/2022.
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
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.utf8)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
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
    
    //MARK: Frame
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    var xRight: CGFloat {
        get {
            return self.x + self.width
        }
        set {
            self.x = newValue - self.width
        }
    }
    var yBottom: CGFloat {
        get {
            return self.y + self.height
        }
        set {
            self.y = newValue - self.height
        }
    }
    var origin: CGPoint {
        set {
            var r = self.frame
            r.origin = newValue
            self.frame = r
        }
        get {
            return self.frame.origin
        }
    }
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var r = self.frame
            r.size = newValue
            self.frame = r
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
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
    
    func convertOrigin(toView:UIView? = nil) -> CGRect {
        var point = self.origin
        var vSup = self.superview
        while(true) {
            if vSup == toView ||
                vSup == nil {
                break
            }
            point.x += (vSup?.x ?? 0)
            point.y += (vSup?.y ?? 0)
            if let vScroll = vSup as? UIScrollView {
                let offset = vScroll.contentOffset
                point.x -= offset.x
                point.y -= offset.y
            }
            vSup = vSup?.superview
        }

        return CGRect(origin: point, size: self.size)
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

//MARK: UIView + Snp contraint
extension UIView {
    /**Add contraint 4 sides: Top,Left,Bottom,Right*/
    func snp4Sides(_ top:CGFloat = 0,_ left:CGFloat = 0,_ bottom:CGFloat = 0,_ right:CGFloat = 0) {
        guard let _ = superview else {
            return
        }
        
        self.snp.makeConstraints { make in
            make.top.equalTo(top)
            make.left.equalTo(left)
            make.bottom.equalTo(bottom)
            make.right.equalTo(right)
        }
    }
}


//MARK: UIView + draw cells
protocol VVViewDrawItem : UIView {
    
    /**Create from code or nib*/
    static func create() -> Self
    
    /**Override to save item, fill data, and calculator self.size **/
    func drawData(_ data:Any)
    var isAutoLayout: Bool {get}
}
extension VVViewDrawItem {
    var isAutoLayout: Bool {
        return false
    }
}

//MARK: Draw items view cell with data and eachHandler
extension UIView {
    /**Horizontal Drawing items cell with T.self class*/
 
    @discardableResult
    func horizontal(_ datas:[Any],_ cls:VVViewDrawItem.Type,padding:CGFloat = 0,align:HVAlign = .center(0),_ eachHandler:((VVViewDrawItem)->Void)? = nil) -> CGSize {
        
        let inset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0)
        
        return _drawItems(isVertical: false, datas, cls, inset,align: align, eachHandler)
    }
    
    @discardableResult
    func grid<T:VVViewDrawItem>(_ datas:[Any],_ cls:T.Type,_ padding:UIEdgeInsets = .zero,rows:Int = 3,_ eachHandler:((T)->Void)? = nil) -> CGSize
    {
        self.removeAllSubviews()
        var width = self.width - CGFloat(rows - 1) * padding.left
        width = floor(width / CGFloat(rows))
        var ox:CGFloat = 0
        var oy:CGFloat = 0
        
        var height:CGFloat = 0
        for data in datas {
            let cell = cls.create()
            cell.drawData(data)
            addSubview(cell)
            
            let newX = ox + width
            if newX > self.width {
                //break line
                oy = oy + cell.height + padding.top
                ox = 0
            }
            cell.frame = .init(x: ox, y: oy, width: width, height: cell.height)
            ox = cell.xRight + padding.left
            
            if let each = eachHandler {
                each(cell)
            }
            height = max(height,cell.yBottom)
        }
        if let cnt = self.cHeight {
            cnt.constant = height
        }else {
            self.height = height
        }
        return .vvSize(self.width, height)
    }
    
    
    @discardableResult
    func vertical(_ datas:[Any],_ cls:VVViewDrawItem.Type,_ padding:UIEdgeInsets = .zero) -> CGSize {
        return vertical(datas, cls, padding,nil)
    }
    
    @discardableResult
    func vertical(_ datas:[Any],_ cls:VVViewDrawItem.Type,_ padding:UIEdgeInsets = .zero,_ eachHandler:((VVViewDrawItem)->Void)? = nil) -> CGSize {
        return _drawItems(isVertical: true, datas, cls, padding, eachHandler)
    }
    @discardableResult
    func vertical(_ datas:[Any],_ cls:VVViewDrawItem.Type,padding:CGFloat = 0,align:HVAlign = .fit(0,0),_ eachHandler:((VVViewDrawItem)->Void)? = nil) -> CGSize {
        return _drawItems(isVertical: true, datas, cls, .vvInset(padding, 0, 0, 0),align:align, eachHandler)
    }
    
    private func _drawItems(isVertical:Bool = true,_ datas:[Any],_ cls:VVViewDrawItem.Type,_ padding:UIEdgeInsets = .zero,align:HVAlign = .center(0),_ eachHandler:((VVViewDrawItem)->Void)?) -> CGSize {
        self.removeAllSubviews()
        var ox:CGFloat = 0
        var oy:CGFloat = 0
        
        //for autolayout
        let isAutolayout = cls.init().isAutoLayout
        var views:[UIView] = []
        
        for data in datas {
            let cell = cls.create()
            
            cell.drawData(data)
            addSubview(cell)
            
            if isAutolayout {
                //add views to autolayouts
                views.append(cell)
            }else {
                if isVertical {
                    cell.origin = .vvPoint(padding.left, oy + padding.top)
                }else {
                        cell.origin = .vvPoint(ox + padding.left, padding.top)
                }
                if isVertical {
                    oy = cell.yBottom
                }else {
                    ox = cell.xRight
                }
            }
            
            if let each = eachHandler {
                each(cell)
            }
        }
        
        if isVertical {
            
            if isAutolayout {
                //add autolayout
                self.cHeight?.priority = .defaultLow
                views.vertical(y: 0,padding.top , align: align)
                return .vvSize(self.width, self.height)
            }
            
            if let cnt = self.cHeight {
                cnt.constant = oy
            }else {
                self.width = oy
            }
            return .vvSize(self.width, oy)
        }else {
            if isAutolayout {
                //add autolayout
                self.cWidth?.priority = .defaultLow
                views.horizontal(x: 0,padding.left,align: align)
                return .vvSize(self.width, self.height)
            }
            if let cnt = self.cWidth {
                cnt.constant = ox
            }else {
                self.width = ox
            }
            return .vvSize(ox, self.height)
        }
    }
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 10

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale =  UIScreen.main.scale
      }
}
