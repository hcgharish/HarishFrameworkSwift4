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
    var md:NSMutableDictionary!
}

protocol CalenderViewDelegate {
    func currentMonthYear (_ monthYear:String, _ view:CalenderView)
    func calenderDateClicked (_ btn:CalenderButton)
}

class CalenderView: UIView {
    
    override func draw(_ rect: CGRect) {
        monthForDate (convertDate (Date()))
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
    
    func monthForDate (_ startDate:Date) {
        var day = calendar.component(.day, from: startDate)
        let month = calendar.component(.month, from: startDate)
        let year = calendar.component(.year, from: startDate)
        
        if delegate != nil {
            delegate.currentMonthYear("\(getMonthName(month)) \(year)", self)
        }
        
        var decrease = -1
        
        day -= 1
        
        let maMonthDays = NSMutableArray()
        
        while day >= 1 {
            
            let date1 = calendar.date(byAdding: .day, value: decrease, to: startDate)
            maMonthDays.insert(convertDate(date1!), at: 0)
            
            if day == 1 {
                var weeekDayPrevious = calendar.component(.weekday, from: date1!)
                
                if weeekDayPrevious == 1 {
                    weeekDayPrevious = 8
                }
                
                while weeekDayPrevious > 2 {
                    decrease -= 1
                    
                    let date2 = calendar.date(byAdding: .day, value: decrease, to: startDate)
                    maMonthDays.insert(convertDate(date2!), at: 0)
                    
                    weeekDayPrevious -= 1
                }
                
                break
            }
            
            decrease -= 1
            day -= 1
        }
        
        maMonthDays.add(startDate)
        
        day = calendar.component(.day, from: startDate)
        
        var increase = 1
        
        var dateNext = calendar.date(byAdding: .day, value: increase, to: startDate)
        var dayNext = calendar.component(.day, from: dateNext!)
        
        var lastDate:Date!
        
        while (dayNext > day) {
            dateNext = calendar.date(byAdding: .day, value: increase, to: startDate)
            lastDate = dateNext
            dayNext = calendar.component(.day, from: dateNext!)
            let monthNext = calendar.component(.month, from: dateNext!)
            
            if monthNext > month {
                maMonthDays.add(convertDate(dateNext!))
                
                var weeekDayNext = calendar.component(.weekday, from: dateNext!)
                
                while (7 > weeekDayNext) {
                    increase += 1
                    dateNext = calendar.date(byAdding: .day, value: increase, to: startDate)
                    lastDate = dateNext
                    maMonthDays.add(convertDate(dateNext!))
                    
                    weeekDayNext += 1
                }
            } else {
                maMonthDays.add(convertDate(dateNext!))
            }
            
            increase += 1
        }
        
        if lastDate != nil {
            increase = 1
            while maMonthDays.count < 42 {
                let date = calendar.date(byAdding: .day, value: increase, to: lastDate)
                maMonthDays.add(convertDate(date!))
                increase += 1
            }
        }
        
        createHolyDays()
        
        for i in 0..<maMonthDays.count {
            let date:Date = (maMonthDays[i] as? Date)!
            
            let currDate = Date()
            
            let comp = date.all(from: currDate)
            
            if (comp.year == 0 && comp.month == 0 && comp.day == 0) {
                if ((comp.hour! <= 0) && (comp.minute! <= 0) && (comp.second! <= 0)) {
                    let md = NSMutableDictionary()
                    md["date"] = date
                    md["borderColor"] = UIColor.red
                    md["borderWidth"] = 0
                    md["backgroundColor"] = UIColor.yellow
                    md["isCurrentDate"] = true
                    md["titleColor"] = UIColor.orange
                    
                    maMonthDays.replaceObject(at: i, with: md)
                }
            }
            
            for j in 0..<holydays.count {
                let date1:Date = (holydays[j] as? Date)!
                
                let comp = date1.all(from: date)
                
                if (comp.year == 0 && comp.month == 0 && comp.day == 0) {
                    if let dt = maMonthDays[i] as? Date {
                        let md = NSMutableDictionary()
                        md["date"] = dt
                        md["borderColor"] = UIColor.red
                        md["borderWidth"] = 1.0
                        md["backgroundColor"] = UIColor.green
                        md["isCurrentDate"] = false
                        md["titleColor"] = UIColor.black
                        
                        maMonthDays.replaceObject(at: i, with: md)
                        
                        break;
                    }
                }
            }
        }
        
        maMonthDays.insert("Sun", at: 0)
        maMonthDays.insert("Sat", at: 0)
        maMonthDays.insert("Fri", at: 0)
        maMonthDays.insert("Thu", at: 0)
        maMonthDays.insert("Wed", at: 0)
        maMonthDays.insert("Tue", at: 0)
        maMonthDays.insert("Mon", at: 0)
        
        createCalButtons (maMonthDays, startDate)
    }
    
    var holydays = NSMutableArray();
    
    func createHolyDays() {
        holydays.add(returnDate("10"))
        holydays.add(returnDate("15"))
        holydays.add(returnDate("23"))
        holydays.add(returnDate("21"))
        holydays.add(returnDate("7"))
        holydays.add(returnDate("22"))
        holydays.add(returnDate("19"))
        holydays.add(returnDate("12"))
    }
    
    func returnDate (_ dat:String) -> Date {
        if dat.count == 1 {
            return "0\(dat)-06-2018 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
        } else {
            return "\(dat)-06-2018 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
        }
    }
    
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
            previousMonth = "15-12-\(year-1) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
            nextMonth = "15-\(month+1)-\(year) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
        } else if month == 12 {
            previousMonth = "15-\(month-1)-\(year) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
            nextMonth = "15-01-\(year+1) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
        } else {
            previousMonth = "15-\(month-1)-\(year) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
            nextMonth = "15-\(month+1)-\(year) 00:00:00 +0000".getDate("dd-MM-yyyy HH:mm:ss z")
        }
        
        let gap:CGFloat = 2
        
        for i in 0..<7 {
            for j in 0..<7 {
                index = i * 7 + j
                
                if maDates.count > index {
                    var x:CGFloat = (CGFloat(j) * sizeButton.width)
                    var y:CGFloat = (CGFloat(i) * sizeButton.height)
                    
                    let width = sizeButton.height - gap
                    let height = sizeButton.height - gap
                    
                    x = x + (sizeButton.width - width) / 2 + gap / 2
                    y = y + gap / 2
                    
                    let btn = CalenderButton(frame: CGRect(x: x, y: y, width: width, height: height))
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
                        
                        var date:Date!
                        
                        var titleColor:UIColor! = UIColor.black
                        
                        if let dt  = maDates[index] as? Date {
                            date = dt
                            
                            btn.border(nil, btn.frame.size.height/2, 0)
                        } else if let md = maDates[index] as? NSMutableDictionary {
                            date = md["date"] as? Date
                            titleColor = md["titleColor"] as? UIColor
                            
                            let borderColor = md["borderColor"] as? UIColor
                            let borderWidth = md["borderWidth"] as? CGFloat
                            let backgroundColor = md["backgroundColor"] as? UIColor

                            btn.backgroundColor = backgroundColor
                            
                            btn.border(borderColor, btn.frame.size.height/2, borderWidth!)
                            
                            btn.md = md
                        }
                        
                        btn.date = date
                        
                        if selectedDate != nil {
                            let comp = date.all(from: (selectedDate?.date)!)
                            
                            if (comp.year == 0 && comp.month == 0 && comp.day == 0) {
                                if (comp.hour! <= 0 && comp.minute! <= 0 && comp.second! <= 0) {
                                    calenderButtonClicked(btn)
                                }
                            }
                        }
                        
                        let monthNow = calendar.component(.month, from: date)
                        
                        if month == monthNow {
                            btn.addTarget(self, action: #selector(calenderButtonClicked (_ :)), for: .touchUpInside)
                            btn.setTitleColor(titleColor, for: .normal)
                        } else {
                            btn.setTitleColor(UIColor.lightGray, for: .normal)
                        }
                        
                        let day = calendar.component(.day, from: date)
                        
                        btn.setTitle("\(day)", for: .normal)
                    }
                }
            }
        }
    }
    
    var selectedDate:CalenderButton? = nil
    
    var nextMonth:Date!
    var previousMonth:Date!
    
    @objc func calenderButtonClicked (_ btn:CalenderButton) {
        selectedDate = btn
        delegate.calenderDateClicked(btn)
        changeClickedButtonBackground (btn)
    }
    
    func showPreviousMonth () {
        monthForDate (convertDate(previousMonth))
    }
    
    func showNextMonth () {
        monthForDate (convertDate(nextMonth))
    }
    
    var selectedButton:CalenderButton? = nil
    
    func changeClickedButtonBackground (_ btn:CalenderButton) {
        if selectedButton == nil {
            selectedButton = btn
        } else {
            //selectedButton?.backgroundColor = UIColor.clear
            reset(selectedButton!)
            
            selectedButton = btn
        }
        
        btn.backgroundColor = UIColor.red
    }
    
    func reset (_ btn:CalenderButton) {
        if btn.md != nil {
            let md = btn.md!
            
            let borderColor = md["borderColor"] as? UIColor
            let borderWidth = md["borderWidth"] as? CGFloat
            let backgroundColor = md["backgroundColor"] as? UIColor
            
            btn.backgroundColor = backgroundColor
            
            btn.border(borderColor, btn.frame.size.height/2, borderWidth!)
        } else {
            btn.backgroundColor = UIColor.clear
        }
    }
}

extension UIButton {
    public func border (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
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
        
        let timeZoneLocal = NSTimeZone.local as TimeZone!
        
        let newDate = Date(timeInterval: TimeInterval((timeZoneLocal?.secondsFromGMT(for: dateUTC))!), since: dateUTC)
        
        return newDate.getStringDate(formate)
    }
}









