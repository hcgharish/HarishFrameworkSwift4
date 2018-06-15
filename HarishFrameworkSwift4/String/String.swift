//
//  String.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

class String1: NSString {

}

public extension String {
    public func currTime () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self//"yyyy-MM-dd HH:mm:ss"//.SSSZ"
        let date = Date()
        let str = dateFormatter.string(from: date)
        
        return str
    }
    
    public func convertToJson() -> Any? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    public func colon () -> String {
        return "\"\(self)\""
    }
    
    public func json () -> Any? {
        let data = self.data(using: String.Encoding.ascii)
        
        if data != nil {
            do {
                return try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    public func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    public func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[Range(start ..< end)])
    }
    
    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGRect {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox
    }
    
    public func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    public func capFirstLetter() -> String {
        let first = String(prefix(1)).capitalized
        let other = String(dropFirst())
        return first + other
    }
    
    mutating public func capFirst() {
        self = self.capFirstLetter()
    }
    
    public func converDate(_ from:String, _ to:String) -> String {
        if self.count == 0 {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = from
        let myDate:Date? = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = to
        
        if myDate == nil {
            return ""
        } else {
            return dateFormatter.string(from: myDate!)
        }
    }
    
    public func getDate(_ formate:String) -> Date {
        if self.count == 0 {
            return Date()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        
        let dttt = dateFormatter.date(from: self)
        
        if dttt == nil {
            return Date()
        } else {
            return dttt!
        }
    }
    
    public func isDate(_ formate:String) -> Date? {
        if self.count == 0 {
            return Date()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.date(from: self)
    }
    
    public func imageName () -> String {
        var name = self.replacingOccurrences(of: ".", with: "_")
        name = name.replacingOccurrences(of: "?", with: "_")
        name = name.replacingOccurrences(of: "=", with: "_")
        name = name.replacingOccurrences(of: ":", with: "_")
        name = name.replacingOccurrences(of: "//", with: "_")
        name = name.replacingOccurrences(of: "/", with: "_")
        name = name.replacingOccurrences(of: "-", with: "_")
        name = name.replacingOccurrences(of: "", with: "_")
        name = "\(name).jpg"
        
        let arr = name.components(separatedBy: "_")
        
        if arr.count > 0 {
            let divide:Int = Int(arr.count / 2);
            
            if (divide <= 0) {
                return name
            } else {
                var newName = ""
                
                for i in divide..<arr.count {
                    newName = "\(newName)\(arr[i])"
                }
                
                return newName
            }
        }
        
        return ""
    }
    
    public func subString (_ str:String) -> Bool {
        if self.range(of: str) != nil {
            return true
        }
        
        return false
    }
    
    public func subInSensetive (_ str:String) -> Bool {
        if (self.range(of: str, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil) != nil) {
            return true
        }
        
        return false
    }
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    public func validate(_ phoneNumber: String) -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phoneNumber == filtered
    }
    
    public func getDateFromUTC (_ formate:String) -> String {
        let dateUTC = self.getDate(formate)
        
        let timeZoneLocal = NSTimeZone.local as TimeZone?
        
        let newDate = Date(timeInterval: TimeInterval((timeZoneLocal?.secondsFromGMT(for: dateUTC))!), since: dateUTC)
        
        return newDate.getStringDate(formate)
    }
}
