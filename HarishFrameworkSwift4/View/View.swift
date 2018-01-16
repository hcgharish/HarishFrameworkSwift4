//
//  View.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

open class View: UIView {
    //    @IBInspectable open var isBorder: Bool = false
    //
    //    @IBInspectable open var border: Int = 0
    //
    //    @IBInspectable open var radious: Int = 0
    //
    //    @IBInspectable open var borderColor: UIColor? = nil
    //
    //    @IBInspectable open var isShadow: Bool = false
    //
    //    @IBInspectable open var shadow_Color: UIColor? = UIColor.darkGray
    //
    //    @IBInspectable open var ls_Opacity:CGFloat = 0.5
    //    @IBInspectable open var ls_Radius:Int = 0
    //
    //    @IBInspectable open var lsOff_Width:CGFloat = 2.0
    //    @IBInspectable open var lsOff_Height:CGFloat = 2.0
    //
    //    @IBInspectable open var isStrokeColor: Bool = false
    
    open var isBorder: Bool = false
    
    open var border: Int = 0
    
    open var radious: Int = 0
    
    open var borderColor: UIColor? = nil
    
    open var isShadow: Bool = false
    
    open var shadow_Color: UIColor? = UIColor.darkGray
    
    open var ls_Opacity:CGFloat = 0.5
    open var ls_Radius:Int = 0
    
    open var lsOff_Width:CGFloat = 2.0
    open var lsOff_Height:CGFloat = 2.0
    
    open var isStrokeColor: Bool = false
    
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
    }
    
    public func layoutSubviews11() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            let color = self.backgroundColor
            self.backgroundColor = UIColor.clear
            
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(self.tag)).cgPath
            shadowLayer.fillColor = color?.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.5
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    public func border1 (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
}

public extension UIView {
    
    public func border (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
    
    public func shadowSubViews () {
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
        
        // add the border to subview
        let borderView = UIView()
        borderView.frame = self.bounds
        borderView.layer.cornerRadius = 10
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.borderWidth = 1.0
        borderView.layer.masksToBounds = true
        self.addSubview(borderView)
        
        // add any other subcontent that you want clipped
        let otherSubContent = UIImageView()
        //otherSubContent.image = UIImage(named: "lion")
        otherSubContent.frame = borderView.bounds
        borderView.addSubview(otherSubContent)
    }
    
    public func shadow () {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = self.frame.size.height/4.0
        self.layer.masksToBounds = false
    }
}

