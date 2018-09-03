//
//  Label.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

protocol LayoutParameters {
    var isBorder: Bool {get set}
    var border: Int {get set}
    var radious: Int {get set}
    var borderColor: UIColor? {get set}
    var isShadow: Bool {get set}
    var shadow_Color: UIColor? {get set}
    var lsOpacity: CGFloat {get set}
    var lsRadius:Int {get set}
    var lsOffWidth: CGFloat {get set}
    var lsOff_Height: CGFloat {get set}
    var isStrokeColor: Bool {get set}
    
    var classPara:ClassPara {get set}
    
    var bounds:CGRect {get set}
}

class ClassPara {
    var backgroundColor:UIColor!
    var shadowLayer:CAShapeLayer!
    var layer: CALayer!
}

extension NSObject {
    func strokeColor() {
        let c = UIGraphicsGetCurrentContext()
        c!.addRect(CGRect(x: 10.0, y: 10.0, width: 80.0, height: 80.0))
        c!.setStrokeColor(UIColor.red.cgColor)
        c!.strokePath()
    }
    
    func layoutSubviews(_ ob:LayoutParameters) {
        
        if ob.isShadow {
            if ob.classPara.shadowLayer == nil {
                let color = ob.classPara.backgroundColor
                ob.classPara.backgroundColor = UIColor.clear
                
                ob.classPara.shadowLayer = CAShapeLayer()
                ob.classPara.shadowLayer.path = UIBezierPath(roundedRect: ob.bounds, cornerRadius: CGFloat(ob.radious)).cgPath
                ob.classPara.shadowLayer.fillColor = color?.cgColor
                
                ob.classPara.shadowLayer.shadowColor = ob.shadow_Color?.cgColor
                ob.classPara.shadowLayer.shadowPath = ob.classPara.shadowLayer.path
                ob.classPara.shadowLayer.shadowOffset = CGSize(width: ob.lsOffWidth, height: ob.lsOff_Height)
                ob.classPara.shadowLayer.shadowOpacity = Float(ob.lsOpacity)
                ob.classPara.shadowLayer.shadowRadius = CGFloat(ob.lsRadius)
                
                ob.classPara.layer.insertSublayer(ob.classPara.shadowLayer, at: 0)
            }
        } else if ob.isBorder {
            doBorder(ob)
        }
    }
    
    func doBorder (_ ob:LayoutParameters) {
        ob.classPara.layer.masksToBounds = true
        if (ob.borderColor != nil) { ob.classPara.layer.borderColor = ob.borderColor?.cgColor }
        ob.classPara.layer.cornerRadius = CGFloat(ob.radious)
        ob.classPara.layer.borderWidth = CGFloat(ob.border)
    }
}

open class Label: UILabel, LayoutParameters {
    var classPara: ClassPara = ClassPara()
    @IBInspectable open var isBorder: Bool = false
    @IBInspectable open var border: Int = 0
    @IBInspectable open var radious: Int = 0
    @IBInspectable open var borderColor: UIColor? = nil
    @IBInspectable open var isShadow: Bool = false
    @IBInspectable open var shadow_Color: UIColor? = UIColor.darkGray
    @IBInspectable open var lsOpacity: CGFloat = 0.5
    @IBInspectable open var lsRadius: Int = 0
    @IBInspectable open var lsOffWidth: CGFloat = 2.0
    @IBInspectable open var lsOff_Height: CGFloat = 2.0
    @IBInspectable open var isStrokeColor: Bool = false
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if isStrokeColor {
            strokeColor()
        }
    }
    
    var shadowLayer: CAShapeLayer!
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let ob = ClassPara ()
        
        ob.shadowLayer = shadowLayer
        ob.backgroundColor = backgroundColor
        ob.layer = layer
        
        classPara = ob

        layoutSubviews (self)
    }
}
