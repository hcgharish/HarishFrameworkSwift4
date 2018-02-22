//
//  TextField.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

open class TextField: UITextField, LayoutParameters {    
    var classPara: ClassPara = ClassPara()
    
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
    
    @IBInspectable open var isMandatory: Bool = false
    
    @IBInspectable open var padding: Int = 0
    
    override open func draw(_ rect: CGRect) {
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
        
        if padding > 0 {
            padding (padding)
        }
    }
    
    public func padding (_ pad:Int) {
        DispatchQueue.main.async {
            let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: pad, height: Int(self.frame.size.height)))
            self.leftView = paddingView;
            self.leftViewMode = UITextFieldViewMode.always
        }
    }
    
    var toolBarDelegate:ToolBarDelegate? = nil
    
    public func toolbar(_ toolBarDelegate:ToolBarDelegate?, _ leftTitle:String?, _ rightTitle:String?, _ backColor:UIColor? = UIColor.darkGray, _ tintColor:UIColor? = UIColor.black, _ btnColor:UIColor? = UIColor.white) {
        self.toolBarDelegate = toolBarDelegate
        
        var items:[UIBarButtonItem] = []
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        doneToolbar.barTintColor = tintColor
        doneToolbar.backgroundColor = backColor
        
        if leftTitle != nil {
            let left: UIBarButtonItem = UIBarButtonItem(title: leftTitle, style: UIBarButtonItemStyle.done, target: self, action: #selector(self.toolTabLeft))
            left.tintColor = btnColor
            items.append(left)
        }
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        items.append(flexSpace)
        
        if rightTitle != nil {
            let right: UIBarButtonItem = UIBarButtonItem(title: rightTitle, style: UIBarButtonItemStyle.done, target: self, action: #selector(self.toolTabRight))
            right.tintColor = btnColor
            items.append(right)
        }
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func toolTabRight() {
        toolBarDelegate?.toolTabRight(self)
    }
    
    @objc func toolTabLeft() {
        toolBarDelegate?.toolTabLeft(self)
    }
    
    public func mandatory () {
        if isMandatory {
            
        let placeH = self.placeholder
        //self.placeholder = placeH! + "*"
        let lbl = UILabel()
        lbl.text = placeH
        lbl.font = self.font
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        
        let size = lbl.frame.size
        
        let lblMand = UILabel()
        var frame = lblMand.frame
        frame.origin.x = self.frame.origin.x + size.width + 10
        frame.origin.y = self.frame.origin.y
        frame.size.width = 15
        frame.size.height = 15
        lblMand.frame = frame
        lblMand.textColor = UIColor.red
        lblMand.text = "*"
        
        self.superview?.addSubview(lblMand)
        }
    }
}

public protocol ToolBarDelegate {
    func toolTabRight(_ any:TextField?)
    func toolTabLeft(_ any:TextField?)
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





//Harish

