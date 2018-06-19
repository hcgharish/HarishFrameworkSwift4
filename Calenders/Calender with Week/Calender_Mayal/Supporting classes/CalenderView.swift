//
//  CalView.swift
//  Calender_Mayal
//
//  Created by Avinash somani on 11/04/17.
//  Copyright © 2017 Kavyasoftech. All rights reserved.
//

import UIKit

class CalenderButton : UIButton {
    var view:CalenderView!
    var date:Date!
}

protocol CalenderViewDelegate {
    func currentMonthYear (_ monthYear:String, _ view:CalenderView)
    func calenderDateClicked (_ btn:CalenderButton)
}

class CalenderView: UIView {
    
    override func draw(_ rect: CGRect) {
        weekForDate (convertDate (Date()))
    }
    
    func convertDate (_ date:Date) -> Date {
        let date = "\(date.getStringDate("dd-MM-yyyy")) 00:00:00  +0000"
        return date.getDate("dd-MM-yyyy HH:mm:ss z")
    }
    
    let calendar = Calendar(identifier: .gregorian)
    
    func getMonthName (_ month:Int) -> String {
        switch month {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return ""
        }
    }
    
    var delegate:CalenderViewDelegate!
    
    func weekForDate(_ startDate:Date) {
        
        let month = calendar.component(.month, from: startDate)
        let year = calendar.component(.year, from: startDate)
        
        if delegate != nil {
            delegate.currentMonthYear("\(getMonthName(month)) \(year)", self)
        }
        
        let weekday = calendar.component(.weekday, from: startDate)

        var dt = 1 - weekday
        
        let maWeekDays = NSMutableArray()
        
        for i in 0..<7 {
            
            
            let date = calendar.date(byAdding: .day, value: dt, to: startDate)
            
            maWeekDays.add(convertDate(date!))
            
            if i == 0 {
                previousWeek = convertDate(calendar.date(byAdding: .day, value: -1, to: date!)!)
            } else if i == 6 {
                nextWeek = convertDate(calendar.date(byAdding: .day, value: 1, to: date!)!)
            }
            
            dt += 1
        }
        
        maWeekDays.insert("Sat", at: 0)
        maWeekDays.insert("Fri", at: 0)
        maWeekDays.insert("Thu", at: 0)
        maWeekDays.insert("Wed", at: 0)
        maWeekDays.insert("Tue", at: 0)
        maWeekDays.insert("Mon", at: 0)
        maWeekDays.insert("Sun", at: 0)
        
        createCalButtons (maWeekDays, startDate)
    }
    
    var nextWeek:Date!
    var previousWeek:Date!
    
    var sizeButton:CGSize!
    
    func createCalButtons (_ maDates:NSMutableArray, _ startDate:Date) {
        sizeButton = CGSize(width: self.frame.size.width / 7.0, height: self.frame.size.height / 7.0)
        
        for vv in self.subviews {
            vv.removeFromSuperview()
        }
        
        var index = 0
        
        let month = calendar.component(.month, from: startDate)
        let year = calendar.component(.year, from: startDate)
        
        if month == 1 {
            previousMonth = "28-12-\(year-1) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
            nextMonth = "1-\(month+1)-\(year) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
        } else if month == 12 {
            previousMonth = "28-\(month-1)-\(year) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
            nextMonth = "1-01-\(year+1) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
        } else {
            previousMonth = "28-\(month-1)-\(year) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
            nextMonth = "1-\(month+1)-\(year) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
        }
        
        for i in 0..<8 {
            for j in 0..<8 {
                index = i * 7 + j
                
                if maDates.count > index {
                    let x:CGFloat = (CGFloat(j) * sizeButton.width)
                    let y:CGFloat = (CGFloat(i) * sizeButton.height)
                    
                    let btn = CalenderButton(frame: CGRect(x: x, y: y, width: sizeButton.width, height: sizeButton.height))
                    btn.view = self
                    self.addSubview(btn)
                    
                    if i == 0 {
                        if j <= 6 {
                            btn.setTitleColor(UIColor.black, for: .normal)
                            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
                            let date:String = (maDates[index] as? String)!
                            btn.setTitle("\(date)", for: .normal)
                        }
                    } else {
                        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
                        
                        let date:Date = (maDates[index] as? Date)!
                        btn.date = date
                        
                        let dayNow = calendar.component(.day, from: date)
                        let monthNow = calendar.component(.month, from: date)
                        let yearNow = calendar.component(.year, from: date)
                        
                        let curDay = calendar.component(.day, from: Date())
                        let curMonth = calendar.component(.month, from: Date())
                        let curYear = calendar.component(.year, from: Date())
                        
                        var clickable = false
                        
                        if yearNow == curYear {
                            if curMonth == monthNow {
                                if curDay == dayNow {
                                    clickable = true
                                } else if curDay < dayNow {
                                    clickable = true
                                } else if curDay > dayNow {
                                    clickable = false
                                }
                            } else if curMonth < monthNow {
                                clickable = true
                            } else if curMonth > monthNow {
                                clickable = false
                            }
                        } else if yearNow < curYear {
                            clickable = false
                        } else if yearNow > curYear {
                            clickable = true
                        }
                        
                        if clickable {
                            btn.addTarget(self, action: #selector(calenderButtonClicked (_ :)), for: .touchUpInside)
                            btn.setTitleColor(UIColor.black, for: .normal)
                        } else {
                            btn.setTitleColor(UIColor.lightGray, for: .normal)
                        }
                        
                        let day = calendar.component(.day, from: date)
                        
                        btn.setTitle("\(day)", for: .normal)
                    }
                }
            }
        }
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = .right
        self.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = .left
        self.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                weekForDate (convertDate (previousWeek)); break
            case .down: break
            case .left:
                weekForDate (convertDate (nextWeek)); break
            case .up: break
            default:
                break
            }
        }
    }
    
    var nextMonth:Date!
    var previousMonth:Date!
 
    @objc func calenderButtonClicked (_ btn:CalenderButton) {
        delegate.calenderDateClicked(btn)
        changeClickedButtonBackground (btn)
    }
    
    func showPreviousMonth () {
        weekForDate (convertDate(previousMonth))
    }
    
    func showNextMonth () {
        weekForDate (convertDate(nextMonth))
    }
    
    func changeClickedButtonBackground (_ btn:CalenderButton) {
        for vv in self.subviews {
            vv.backgroundColor = UIColor.clear
        }
        
        btn.backgroundColor = UIColor.red
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    func all(from date: Date) -> DateComponents {
        //print("self-\(self)-")
        //print("date-\(date)-")
        return Calendar.current.dateComponents([.year, .month, .hour, .day, .minute, .second], from: date, to: self)
        
        //return Calendar.current.dateComponents([.year, .month, .hour, .day, .minute, .second], from: date, to: self).second ?? 0
    }
    
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    func getStringDate(_ formate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.string(from: self)
    }
}

extension String {
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[Range(start ..< end)])
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGRect {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func capFirstLetter() -> String {
        let first = String(prefix(1)).capitalized
        let other = String(dropFirst())
        return first + other
    }
    
    mutating func capFirst() {
        self = self.capFirstLetter()
    }
    
    func converDate(_ from:String, _ to:String) -> String {
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
    
    func getDate(_ formate:String) -> Date {
        if self.count == 0 {
            return Date()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.date(from: self)!
    }
    
    func imageName () -> String {
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
    
    func subString (_ str:String) -> Bool {
        if self.range(of: str) != nil {
            return true
        }
        
        return false
    }
    
    func subInSensetive (_ str:String) -> Bool {
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
    
    func validate(_ phoneNumber: String) -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phoneNumber == filtered
    }
    
    func getDateFromUTC (_ formate:String) -> String {
        let dateUTC = self.getDate(formate)
        
        let timeZoneLocal = NSTimeZone.local as TimeZone?
        
        let newDate = Date(timeInterval: TimeInterval((timeZoneLocal?.secondsFromGMT(for: dateUTC))!), since: dateUTC)
        
        return newDate.getStringDate(formate)
    }
}









