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
            
            self.container?.backgroundColor = UIColor.red
            
            self.appDelegate?.window??.addSubview(self.container!)
            
            let size:CGFloat = 20.0
            let gap:CGFloat = 5.0
            
            let vieee1 = UIView()
            var frame1 = (self.appDelegate?.window??.frame)!
            frame1.size.width = size
            frame1.size.height = size
            vieee1.frame = frame1
            vieee1.backgroundColor = UIColor.green
            vieee1.center = (self.appDelegate?.window??.center)!
            self.appDelegate?.window??.addSubview(vieee1)
            
            let vieee2 = UIView()
            var frame2 = (self.appDelegate?.window??.frame)!
            frame2.size.width = size
            frame2.size.height = size
            vieee2.frame = frame2
            vieee2.backgroundColor = UIColor.green
            vieee2.center = (self.appDelegate?.window??.center)!
            
            self.appDelegate?.window??.addSubview(vieee2)
            
            let vieee3 = UIView()
            var frame3 = (self.appDelegate?.window??.frame)!
            frame3.size.width = size
            frame3.size.height = size
            vieee3.frame = frame3
            vieee3.backgroundColor = UIColor.green
            vieee3.center = (self.appDelegate?.window??.center)!
            self.appDelegate?.window??.addSubview(vieee3)
            
            vieee1.frame.origin.x = vieee1.frame.origin.x + CGFloat(0.0 * size + 0.0 * gap)
            vieee2.frame.origin.x = vieee2.frame.origin.x + CGFloat(1.0 * size + 1.0 * gap)
            vieee3.frame.origin.x = vieee3.frame.origin.x + CGFloat(2.0 * size + 2.0 * gap)
            
            let diff = vieee2.center.x - (vieee2.superview?.center.x)!
            
            vieee1.frame.origin.x = vieee1.frame.origin.x - diff
            vieee2.frame.origin.x = vieee2.frame.origin.x - diff
            vieee3.frame.origin.x = vieee3.frame.origin.x - diff
            
            let c1 = vieee1.center
            let c2 = vieee2.center
            let c3 = vieee3.center
            
            let sllep:UInt32 = 330000
            
            DispatchQueue.global().async {
                self.animate (vieee1, c1)
                usleep(sllep)
                self.animate (vieee2, c2)
                usleep(sllep)
                self.animate (vieee3, c3)
            }
        }
    }
    
    func animate (_ view:UIView, _ center:CGPoint) {
        DispatchQueue.main.async {
            var frame = view.frame
            
            if frame.size.width == 20 && frame.size.height == 20 {
                frame.size.width = 0
                frame.size.height = 0
            } else {
                frame.size.width = 20
                frame.size.height = 20
            }
            
            UIView.animate(withDuration: 1.0, animations: {
                view.frame = frame
                view.center = center
                
                view.layer.masksToBounds = true
                view.layer.borderColor = UIColor.clear.cgColor
                view.layer.cornerRadius = frame.size.height / 2 
                view.layer.borderWidth = 0
            }) { (bool) in
                self.animate (view, center)
            }
        }
    }
}






