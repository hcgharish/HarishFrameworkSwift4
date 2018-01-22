//
//  Label.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

open class Label: UILabel {
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
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
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
        
        if isMandatory {
            mandatory ()
        }
    }
    
    @IBInspectable open var isMandatory: Bool = false
    
    public func border1 (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
    
    public func mandatory () {
        let placeH = self.text
        //self.placeholder = placeH! + "*"
        let lbl = UILabel()
        lbl.text = placeH
        lbl.font = self.font
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        
        let size = lbl.frame.size
        
        let lblMand = UILabel()
        var frame = lblMand.frame
        
        if self.textAlignment == .left {
            frame.origin.x = self.frame.origin.x + size.width + 10
        } else if self.textAlignment == .right {
            frame.origin.x = self.frame.origin.x + self.frame.size.width + 5
        } else if self.textAlignment == .center {
            frame.origin.x = self.frame.origin.x + (self.frame.size.width / 2) + (size.width / 2) + 10
        }
        
        frame.origin.y = self.frame.origin.y
        frame.size.width = 15
        frame.size.height = 15
        lblMand.frame = frame
        lblMand.textColor = UIColor.red
        lblMand.text = "*"
        
        self.superview?.addSubview(lblMand)
    }
}
