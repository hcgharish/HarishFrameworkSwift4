//
//  Dictionary.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

class Dictionary1: NSDictionary {

}

public extension NSDictionary {
    public func convertToString () -> String {
        do {
            let jsonData: NSData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            
            let str = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
            
            return str.replacingOccurrences(of: "\n", with: "")
        } catch {
            
        }
        
        return "[]"
    }
    
    public func getMutable (_ md:NSMutableDictionary?) -> NSMutableDictionary? {
        let dict = self
        
        var md = md
        
        if md == nil {
            md = NSMutableDictionary ()
        }
        
        let arr = dict.allKeys
        
        for i in 0..<arr.count {
            if let val = dict[arr[i]] as? String {
                md?[arr[i]] = val
            } else if let val = dict[arr[i]] as? Double {
                md?[arr[i]] = val
            } else if let val = dict[arr[i]] as? Int {
                md?[arr[i]] = val
            } else if let val = dict[arr[i]] as? NSArray {
                md?[arr[i]] = val.getMutable(nil)
            } else if let val = dict[arr[i]] as? NSDictionary {
                md?[arr[i]] = val.getMutable(md)
            } else if let val = dict[arr[i]] as? Float {
                md?[arr[i]] = val
            }
        }
        
        return md
    }
    
    public func convertToString (_ caller:Bool = true) -> String {
        var str = "{"
        
        for (key, value) in self {
            let key = key as! String
            if (str.count == 1) {
                if value is String {
                    str = "\(str)\(key.colon ()):\("\(value)".colon ())"
                } else if value is Double {
                    str = "\(str)\(key.colon ()):\("\(value)".colon ())"
                } else if value is Int {
                    str = "\(str)\(key.colon ()):\("\(value)".colon ())"
                } else if let val = value as? NSArray {
                    str = "\(str)\(key.colon ()):\(val.convertToString(false))"
                } else if value is NSDictionary {
                    str = "\(str)\(key.colon ()):\(convertToString(false))"
                } else if value is Float {
                    str = "\(str)\(key.colon ()):\("\(value)".colon ())"
                } else if value is Bool {
                    str = "\(str)\(key.colon ()):\("\(value)".colon ())"
                } else if value is Double {
                    str = "\(str)\(key.colon ()):\("\(value)".colon ())"
                }
            } else {
                if value is String {
                    str = "\(str), \(key.colon ()):\("\(value)".colon ())"
                } else if value is Double {
                    str = "\(str), \(key.colon ()):\("\(value)".colon ())"
                } else if value is Int {
                    str = "\(str), \(key.colon ()):\("\(value)".colon ())"
                } else if let val = value as? NSArray {
                    str = "\(str),\(key.colon ()):\(val.convertToString(false))"
                } else if value is NSDictionary {
                    str = "\(str),\(key.colon ()):\(convertToString(false))"
                } else if value is Float {
                    str = "\(str), \(key.colon ()):\("\(value)".colon ())"
                } else if value is Bool {
                    str = "\(str), \(key.colon ()):\("\(value)".colon ())"
                } else if value is Double {
                    str = "\(str), \(key.colon ()):\("\(value)".colon ())"
                }
            }
        }
        
        if caller {
            return "\(str)}".colon ()
        } else {
            return "\(str)}"
        }
    }
}
