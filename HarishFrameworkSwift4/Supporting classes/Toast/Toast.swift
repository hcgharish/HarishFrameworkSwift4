//
//  Toast.swift
//  Swift3_Http
//
//  Created by Harish on 16/11/17.
//  Copyright © 2017 Kavyasoftech. All rights reserved.
//

import UIKit

public class Toast: UIView {
    public func show (_ msg:String) {
        DispatchQueue.main.async {
            let app = UIApplication.shared.delegate
            
            if app?.window != nil {
                if msg.count > 0 {
                    let lbl = UILabel()
                    var frame_lbl = lbl.frame
                    lbl.frame = frame_lbl
                    lbl.textColor = UIColor.white
                    lbl.textAlignment = .center
                    lbl.text = msg

                    lbl.font = UIFont.systemFont(ofSize: 14.0)
                    lbl.numberOfLines = 0
                    lbl.sizeToFit()
                    
                    frame_lbl = lbl.frame
                    frame_lbl.size.width = frame_lbl.size.width + 20
                    lbl.frame = frame_lbl
                    
                    let view = self
                    
                    var frame_view = frame_lbl
                    frame_view.size.width = frame_lbl.size.width + 20
                    frame_view.size.height = frame_lbl.size.height + 20
                    frame_view.origin.x = (UIScreen.main.bounds.size.width / 2) - (frame_view.size.width / 2)
                    frame_view.origin.y = UIScreen.main.bounds.size.height - frame_view.size.height - 20
                    view.frame = frame_view
                    
                    lbl.center = CGPoint(x: frame_view.size.width/2, y: frame_view.size.height/2)
                    
                    view.backgroundColor = UIColor.black
                    
                    let window:UIWindow? = (app?.window)!
                    
                    view.layer.masksToBounds = true
                    view.layer.cornerRadius = 10
                    
                    view.addSubview(lbl)
                    window?.addSubview(view)
                    
                    self.remove ()
                }
            }
        }
    }
    
    func remove () {
        DispatchQueue.global().async {
            sleep(2)
            
            DispatchQueue.main.async {
                self.removeFromSuperview()
            }
        }
    }
    
    static let toasts = NSMutableArray()
    static var watcher_working = false
    
    public class func toast (_ msg:String) {
        lockQueue.sync {
            toasts.insert(msg, at: 0)
        }
        
        if watcher_working == false {
            watcher_working = true
            
            watcher ()
        }
    }
    
    class func watcher () {
        DispatchQueue.global().async {
            while watcher_working {
                lockQueue.sync {
                    if toasts.count >= 1 {
                        DispatchQueue.main.async {
                            let msg = toasts[toasts.count - 1]
                            
                            let view = Toast()
                            view.show(msg as! String)
                            
                            toasts.removeLastObject()
                        }
                    }
                }
                
                if toasts.count == 0 {
                    watcher_working = false
                    break
                }
                
                usleep(useconds_t(2.1 * 1000000))
            }
        }
    }
}

let lockQueue = DispatchQueue.init(label: "com.kavya.LockQueue")







