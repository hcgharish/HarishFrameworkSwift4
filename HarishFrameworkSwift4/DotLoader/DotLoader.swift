//
//  DotLoader.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 31/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

let lock_Queue = DispatchQueue.init(label: "com.kavya.lock_Queue.dotloader")
let dotSize:CGFloat = 20
var stopped = false

let one_second = 1000000

public class DotLoader: NSObject {
    var container: UIView? = nil
    var containerSuper: UIView? = nil
    
    var appDelegate:UIApplicationDelegate? = nil
    
    public static let shared: DotLoader = { DotLoader () } ()
    
    var noofrequest = 0
    
    public var animateDotLoader = false
    public var dotColor = UIColor.white
    public var loaderContainerColor = UIColor.gray
    public var dullnessColor:UIColor? = nil
    
    public func showLoader () {
        DispatchQueue.main.async {
            if self.noofrequest == 0 {
                stopped = false
                
                if self.dullnessColor == nil {
                    self.dullnessColor = UIColor.hexColor(0x000000, alpha:0.5)
                }
                
                self.appDelegate = UIApplication.shared.delegate
                
                self.container = UIView()
                self.containerSuper = UIView()
                
                self.containerSuper?.frame = (self.appDelegate?.window??.frame)!
                self.containerSuper?.center = (self.appDelegate?.window??.center)!
                
                self.containerSuper?.backgroundColor = self.dullnessColor
                
                self.container?.frame = CGRect(x:0.0, y:0.0, width:0.0, height:0.0)
                self.container?.frame.size.width = 100.0
                self.container?.frame.size.height = 100.0
                self.container?.center = (self.appDelegate?.window??.center)!
                
                self.container?.border5(dotSize / 2)
                
                self.container?.backgroundColor = self.loaderContainerColor
                
                self.containerSuper?.addSubview(self.container!)
                self.appDelegate?.window??.addSubview(self.containerSuper!)
                
                let gap:CGFloat = 5.0
                
                let vieee1 = UIView()
                var frame1 = CGRect(x:0.0, y:0.0, width:0.0, height:0.0)
                frame1.size.width = dotSize
                frame1.size.height = dotSize
                vieee1.frame = frame1
                vieee1.backgroundColor = self.dotColor
                vieee1.center = CGPoint(x:(self.container?.frame.size.width)!/2, y:(self.container?.frame.size.height)!/2)
                self.container?.addSubview(vieee1)
                vieee1.border5(dotSize / 2)
                
                let vieee2 = UIView()
                var frame2 = CGRect(x:0.0, y:0.0, width:0.0, height:0.0)
                frame2.size.width = dotSize
                frame2.size.height = dotSize
                vieee2.frame = frame2
                vieee2.backgroundColor = self.dotColor
                vieee2.center = CGPoint(x:(self.container?.frame.size.width)!/2, y:(self.container?.frame.size.height)!/2)
                self.container?.addSubview(vieee2)
                vieee2.border5(dotSize / 2)
                
                let vieee3 = UIView()
                var frame3 = CGRect(x:0.0, y:0.0, width:0.0, height:0.0)
                frame3.size.width = dotSize
                frame3.size.height = dotSize
                vieee3.frame = frame3
                vieee3.backgroundColor = self.dotColor
                vieee3.center = CGPoint(x:(self.container?.frame.size.width)!/2, y:(self.container?.frame.size.height)!/2)
                self.container?.addSubview(vieee3)
                vieee3.border5(dotSize / 2)
                
                vieee1.frame.origin.x = vieee1.frame.origin.x + CGFloat(0.0 * dotSize + 0.0 * gap)
                vieee2.frame.origin.x = vieee2.frame.origin.x + CGFloat(1.0 * dotSize + 1.0 * gap)
                vieee3.frame.origin.x = vieee3.frame.origin.x + CGFloat(2.0 * dotSize + 2.0 * gap)
                
                let diff = vieee2.center.x - (vieee2.superview?.frame.size.width)! / 2
                
                vieee1.frame.origin.x = vieee1.frame.origin.x - diff
                vieee2.frame.origin.x = vieee2.frame.origin.x - diff
                vieee3.frame.origin.x = vieee3.frame.origin.x - diff
                
                let c1 = vieee1.center
                let c2 = vieee2.center
                let c3 = vieee3.center
                
                let sllep:UInt32 = UInt32(one_second / 3)
                
                DispatchQueue.global().async {
                    vieee1.animate (c1)
                    usleep(sllep)
                    vieee2.animate (c2)
                    usleep(sllep)
                    vieee3.animate (c3)
                }
            }
            
            self.noofrequest += 1
        }
    }
    
    public func stopLoader() {
        DispatchQueue.global().async {
            while self.noofrequest == 0 {
                sleep(1)
            }
            
            DispatchQueue.main.async {
                lock_Queue.sync {
                    
                    if self.noofrequest == 1 {
                        stopped = true
                        self.containerSuper?.removeFromSuperview()
                    }
                    
                    if self.noofrequest > 0 {
                        self.noofrequest -= 1
                    }
                }
            }
        }
    }
}

extension UIView {
    func animate (_ center:CGPoint) {
        DispatchQueue.global().async {
            var incdec:CGFloat = 1
            let time = UInt32(CGFloat(one_second)  / dotSize)
            
            while stopped == false {
                DispatchQueue.main.async {
                    var frame = self.frame
                    
                    if frame.size.width == dotSize && frame.size.height == dotSize {
                        incdec = -1
                    } else if frame.size.width == 0 && frame.size.height == 0 {
                        incdec = 1
                    }
                    
                    frame.size.width = frame.size.width + incdec
                    frame.size.height = frame.size.height + incdec
                    
                    self.frame = frame
                    self.center = center
                    
                    self.border5(frame.size.height/2)
                }
                usleep(UInt32(time))
            }
        }
    }
    
    func border5(_ radious:CGFloat) {
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = radious
        self.layer.borderWidth = 0
    }
}






