//
//  Array.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

class Array1: NSArray {

}

public extension NSArray {
    public func string () -> String {
        do {
            let jsonData: NSData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            
            let str = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
            
            return str.replacingOccurrences(of: "\n", with: "")
        } catch {
            
        }
        
        return "[]"
    }
    
    public func getMutable (_ ma:NSMutableArray?) -> NSMutableArray? {
        let array = self
        
        var ma = ma
        
        if ma == nil {
            ma = NSMutableArray ()
        }
        
        for i in 0..<array.count {
            if let val = array[i] as? String {
                ma?.add(val)
            } else if let val = array[i] as? Double {
                ma?.add(val)
            } else if let val = array[i] as? Int {
                ma?.add(val)
            } else if let val = array[i] as? NSArray {
                ma?.add(NSMutableArray(array: val.getMutable(ma)!))
            } else if let val = array[i] as? NSDictionary {
                ma?.add(NSMutableDictionary(dictionary: val.getMutable(nil)!))
            } else if let val = array[i] as? Float {
                ma?.add(val)
            }
        }
        
        return ma
    }
    
    public func toString (_ caller:Bool = true)  -> String {
        var str = "["
        
        for i in 0..<self.count {
            if (str.count == 1) {
                if let val = self[i] as? String {
                    str = "\(str)\(val.colon ())"
                } else if let val = self[i] as? Double {
                    str = "\(str)\("\(val)".colon ())"
                } else if let val = self[i] as? Int {
                    str = "\(str)\("\(val)".colon ())"
                } else if let val = self[i] as? NSArray {
                    str = "\(str)\(val.toString(false))"
                } else if let val = self[i] as? NSDictionary {
                    str = "\(str)\(val.toString(false))"
                } else if let val = self[i] as? Float {
                    str = "\(str)\("\(val)".colon ())"
                } else if let val = self[i] as? Bool {
                    str = "\(str)\("\(val)".colon ())"
                } else if let val = self[i] as? Double {
                    str = "\(str)\("\(val)".colon ())"
                }
            } else {
                if let val = self[i] as? String {
                    str = "\(str),\(val.colon ())"
                } else if let val = self[i] as? Double {
                    str = "\(str),\("\(val)".colon ())"
                } else if let val = self[i] as? Int {
                    str = "\(str),\("\(val)".colon ())"
                } else if let val = self[i] as? NSArray {
                    str = "\(str),\(val.toString(false))"
                } else if let val = self[i] as? NSDictionary {
                    str = "\(str),\(val.toString(false))"
                } else if let val = self[i] as? Float {
                    str = "\(str),\("\(val)".colon ())"
                } else if let val = self[i] as? Bool {
                    str = "\(str),\("\(val)".colon ())"
                } else if let val = self[i] as? Double {
                    str = "\(str),\("\(val)".colon ())"
                }
            }
        }
        
        if caller {
            return "\(str)]".colon ()
        } else {
            return "\(str)]"
        }
    }
}
