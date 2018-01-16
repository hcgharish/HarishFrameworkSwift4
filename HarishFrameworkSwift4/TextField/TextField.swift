//
//  TextField.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

open class TextField: UITextField {
    @IBInspectable open var isBorder: Bool = false
    
    @IBInspectable open var border: Int = 0
    
    @IBInspectable open var radious: Int = 0
    
    @IBInspectable open var borderColor: UIColor? = nil
    
    @IBInspectable open var isShadow: Bool = false
    
    @IBInspectable open var shadow_Color: UIColor? = UIColor.darkGray
    
    @IBInspectable open var ls_Opacity:CGFloat = 0.5
    @IBInspectable open var ls_Radius:Int = 0
    
    @IBInspectable open var lsOff_Width:CGFloat = 2.0
    @IBInspectable open var lsOff_Height:CGFloat = 2.0
    
    @IBInspectable open var isStrokeColor: Bool = false
    
    @IBInspectable open var padding: Int = 0
    
    override open func draw(_ rect: CGRect) {
        if isStrokeColor {
            let c = UIGraphicsGetCurrentContext()
            c!.addRect(CGRect(x: 10.0, y: 10.0, width: 80.0, height: 80.0))
            c!.setStrokeColor(UIColor.red.cgColor)
            c!.strokePath()
        }
    }
    
    var shadowLayer: CAShapeLayer!
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if isShadow {
            if shadowLayer == nil {
                let color = self.backgroundColor
                self.backgroundColor = UIColor.clear
                
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(radious)).cgPath
                shadowLayer.fillColor = color?.cgColor
                
                shadowLayer.shadowColor = shadow_Color?.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: lsOff_Width, height: lsOff_Height)
                shadowLayer.shadowOpacity = Float(ls_Opacity)
                shadowLayer.shadowRadius = CGFloat(ls_Radius)
                
                layer.insertSublayer(shadowLayer, at: 0)
            }
        } else if isBorder {
            border1(borderColor, CGFloat(radious), CGFloat(border))
        }
        
        if padding > 0 {
            padding (padding)
        }
    }
    
    public func padding (_ pad:Int) {
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: pad, height: Int(self.frame.size.height)))
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    public func border1 (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
}

public extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}
