//
//  DotLoader.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 31/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

public class DotLoader: NSObject {
    var container: UIView? = nil
    
    var appDelegate:UIApplicationDelegate? = nil
    
    public static let shared: DotLoader = { DotLoader () } ()
    
    public func showLoader () {
        DispatchQueue.main.async {
            self.container = UIView()
            
            self.appDelegate = UIApplication.shared.delegate
            
            self.container?.frame = (self.appDelegate?.window??.frame)!
            self.container?.center = (self.appDelegate?.window??.center)!
            
            self.container?.backgroundColor = UIColor.red//self.UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
            
            self.appDelegate?.window??.addSubview(self.container!)
            
            print("self.appDelegate-\(self.appDelegate)-")
            print("self.container-\(self.container)-")
            
            let vieee = UIView()
            var frame = (self.appDelegate?.window??.frame)!
            frame.size.width = 20
            frame.size.height = 20
            vieee.frame = frame
            vieee.backgroundColor = UIColor.green
            vieee.center = (self.appDelegate?.window??.center)!
            self.appDelegate?.window??.addSubview(vieee)
            
            self.animate (vieee)
        }
    }
    
    func animate (_ view:UIView) {
        var frame = view.frame
        
        if frame.size.width == 20 && frame.size.height == 20 {
            frame.size.width = 0
            frame.size.height = 0
        } else {
            frame.size.width = 20
            frame.size.height = 20
        }
        
        UIView.animate(withDuration: 2.0, animations: {
            view.frame = frame
        }) { (bool) in
            self.animate (view)
        }
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}






