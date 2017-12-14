//
//  HttpsRequest.swift
//  jsonSwift
//
//  Created by Harish on 6/15/15.
//  Copyright (c) 2015 Harish. All rights reserved.
//

import UIKit
import MapKit

let kCouldnotconnect = "Could not connect to the server. Please try again later."
let kInternetNotAvailable = "Please establish network connection."

//
//  ValidatorClass.swift
//  Zooma
//
//  Created by kavya_mac_1 on 12/15/16.
//  Copyright © 2016 kavya_mac_1. All rights reserved.
//

import UIKit

open class Valid: NSObject {
    
    let NameAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
    
    open class func email(_ testStr:String) -> Bool {
        var count = 0
        
        for r in testStr {
            
            if r == "@" {
                count += 1
            }
        }
        
        if count > 1 {
            return false
        }
        
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
            return regex.firstMatch(in: testStr, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, testStr.count)) != nil
        } catch {
            print("hgkjhgjkgh")
            return false
        }
    }
    
    open class func url (_ testStr:String) -> Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
            return regex.firstMatch(in: testStr, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, testStr.count)) != nil
        } catch {
            return false
        }
    }
    
    open class func fiscale(_ testStr: String) -> Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: "[A-Za-z]{6}[0-9lmnpqrstuvLMNPQRSTUV]{2}[abcdehlmprstABCDEHLMPRST]{1}[0-9lmnpqrstuvLMNPQRSTUV]{2}[A-Za-z]{1}[0-9lmnpqrstuvLMNPQRSTUV]{3}[A-Za-z]{1}", options: .caseInsensitive)
            return regex.firstMatch(in: testStr, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, testStr.count)) != nil
            
        } catch {
            return false
        }
    }
    
    open class func password (_ testStr: String) -> Bool {
        
        if testStr.count < 8 {
            return false
        }
        return true
    }
    
    open class func name(strTest: String) -> Bool {
        
        let numberCharacters = NSCharacterSet.decimalDigits
        
        if strTest.rangeOfCharacter(from: numberCharacters) != nil {
            return false
        }
        else if strTest.rangeOfCharacter(from: numberCharacters) == nil {
            return true
        }
        return true
    }
}

open class View : UIView {
//    @IBInspectable open var isBorder: Bool = false
//
//    @IBInspectable open var border: Int = 0
//
//    @IBInspectable open var radious: Int = 0
//
//    @IBInspectable open var borderColor: UIColor? = nil
//
//    @IBInspectable open var isShadow: Bool = false
//
//    @IBInspectable open var shadow_Color: UIColor? = UIColor.darkGray
//
//    @IBInspectable open var ls_Opacity:CGFloat = 0.5
//    @IBInspectable open var ls_Radius:Int = 0
//
//    @IBInspectable open var lsOff_Width:CGFloat = 2.0
//    @IBInspectable open var lsOff_Height:CGFloat = 2.0
//
//    @IBInspectable open var isStrokeColor: Bool = false
    
     open var isBorder: Bool = false
    
     open var border: Int = 0
    
     open var radious: Int = 0
    
     open var borderColor: UIColor? = nil
    
     open var isShadow: Bool = false
    
     open var shadow_Color: UIColor? = UIColor.darkGray
    
     open var ls_Opacity:CGFloat = 0.5
     open var ls_Radius:Int = 0
    
     open var lsOff_Width:CGFloat = 2.0
     open var lsOff_Height:CGFloat = 2.0
    
     open var isStrokeColor: Bool = false
    
    override open func draw(_ rect: CGRect) {
        if isStrokeColor {
            let c = UIGraphicsGetCurrentContext()
            c!.addRect(CGRect(x: 10.0, y: 10.0, width: 80.0, height: 80.0))
            c!.setStrokeColor(UIColor.red.cgColor)
            c!.strokePath()
        }
    }
    
    var shadowLayer: CAShapeLayer!
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if isShadow {
            if shadowLayer == nil {
                let color = self.backgroundColor
                self.backgroundColor = UIColor.clear
                
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(radious)).cgPath
                shadowLayer.fillColor = color?.cgColor
                
                shadowLayer.shadowColor = shadow_Color?.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: lsOff_Width, height: lsOff_Height)
                shadowLayer.shadowOpacity = Float(ls_Opacity)
                shadowLayer.shadowRadius = CGFloat(ls_Radius)
                
                layer.insertSublayer(shadowLayer, at: 0)
            }
        } else if isBorder {
            border1(borderColor, CGFloat(radious), CGFloat(border))
        }
    }
    
    public func layoutSubviews11() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            let color = self.backgroundColor
            self.backgroundColor = UIColor.clear
            
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(self.tag)).cgPath
            shadowLayer.fillColor = color?.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.5
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    public func border1 (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
}

open class Label : UILabel {
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
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if isStrokeColor {
            let c = UIGraphicsGetCurrentContext()
            c!.addRect(CGRect(x: 10.0, y: 10.0, width: 80.0, height: 80.0))
            c!.setStrokeColor(UIColor.red.cgColor)
            c!.strokePath()
        }
    }
    
    var shadowLayer: CAShapeLayer!
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if isShadow {
            if shadowLayer == nil {
                let color = self.backgroundColor
                self.backgroundColor = UIColor.clear
                
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(radious)).cgPath
                shadowLayer.fillColor = color?.cgColor
                
                shadowLayer.shadowColor = shadow_Color?.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: lsOff_Width, height: lsOff_Height)
                shadowLayer.shadowOpacity = Float(ls_Opacity)
                shadowLayer.shadowRadius = CGFloat(ls_Radius)
                
                layer.insertSublayer(shadowLayer, at: 0)
            }
        } else if isBorder {
            border1(borderColor, CGFloat(radious), CGFloat(border))
        }
    }
    
    public func border1 (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
}

open class TextView : UITextView {
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
    
    override open func draw(_ rect: CGRect) {
        if isStrokeColor {
            let c = UIGraphicsGetCurrentContext()
            c!.addRect(CGRect(x: 10.0, y: 10.0, width: 80.0, height: 80.0))
            c!.setStrokeColor(UIColor.red.cgColor)
            c!.strokePath()
        }
    }
    
    var shadowLayer: CAShapeLayer!
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if isShadow {
            if shadowLayer == nil {
                let color = self.backgroundColor
                self.backgroundColor = UIColor.clear
                
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(radious)).cgPath
                shadowLayer.fillColor = color?.cgColor
                
                shadowLayer.shadowColor = shadow_Color?.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: lsOff_Width, height: lsOff_Height)
                shadowLayer.shadowOpacity = Float(ls_Opacity)
                shadowLayer.shadowRadius = CGFloat(ls_Radius)
                
                layer.insertSublayer(shadowLayer, at: 0)
            }
        } else if isBorder {
            border1(borderColor, CGFloat(radious), CGFloat(border))
        }
    }
    
    public func border1 (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
}

open class TextField : UITextField {
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
    
    @IBInspectable open var padding: Int = 0
    
    override open func draw(_ rect: CGRect) {
        if isStrokeColor {
            let c = UIGraphicsGetCurrentContext()
            c!.addRect(CGRect(x: 10.0, y: 10.0, width: 80.0, height: 80.0))
            c!.setStrokeColor(UIColor.red.cgColor)
            c!.strokePath()
        }
    }
    
    var shadowLayer: CAShapeLayer!
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if isShadow {
            if shadowLayer == nil {
                let color = self.backgroundColor
                self.backgroundColor = UIColor.clear
                
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(radious)).cgPath
                shadowLayer.fillColor = color?.cgColor
                
                shadowLayer.shadowColor = shadow_Color?.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: lsOff_Width, height: lsOff_Height)
                shadowLayer.shadowOpacity = Float(ls_Opacity)
                shadowLayer.shadowRadius = CGFloat(ls_Radius)
                
                layer.insertSublayer(shadowLayer, at: 0)
            }
        } else if isBorder {
            border1(borderColor, CGFloat(radious), CGFloat(border))
        }
        
        if padding > 0 {
            padding (padding)
        }
    }
    
    public func padding (_ pad:Int) {
        let paddingView = UIView(frame:CGRect(x: 0, y: 0, width: pad, height: Int(self.frame.size.height)))
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    public func border1 (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
}

open class Button : UIButton {
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
    
    override open func draw(_ rect: CGRect) {
        if isStrokeColor {
            let c = UIGraphicsGetCurrentContext()
            c!.addRect(CGRect(x: 10.0, y: 10.0, width: 80.0, height: 80.0))
            c!.setStrokeColor(UIColor.red.cgColor)
            c!.strokePath()
        }
    }
    
    var shadowLayer: CAShapeLayer!
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if isShadow {
            if shadowLayer == nil {
                let color = self.backgroundColor
                self.backgroundColor = UIColor.clear
                
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(radious)).cgPath
                shadowLayer.fillColor = color?.cgColor
                
                shadowLayer.shadowColor = shadow_Color?.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: lsOff_Width, height: lsOff_Height)
                shadowLayer.shadowOpacity = Float(ls_Opacity)
                shadowLayer.shadowRadius = CGFloat(ls_Radius)
                
                layer.insertSublayer(shadowLayer, at: 0)
            }
        } else if isBorder {
            border1(borderColor, CGFloat(radious), CGFloat(border))
        }
    }
    
    public func border1 (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
}

open class Http: NSObject {
    open class func instance () -> Http {
        return Http()
    }
    
    public func json (_ api:String?,_ params:NSMutableDictionary?, _ method:String?, ai:Bool, popup:Bool, prnt:Bool, _ header:NSDictionary? = nil , _ images:NSMutableArray? = nil, sync:Bool = false, completionHandler: @escaping (NSDictionary?, NSMutableDictionary?, String) -> Swift.Void) {
        
        let reach = Reachability.init(hostname: "google.com")
        
        if (reach?.isReachable)! {
            if ai {
                startActivityIndicator()
            }
            
            var request = NSMutableURLRequest(url: NSURL(string: (api!.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!))! as URL)
            
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 180.0
            config.timeoutIntervalForResource = 180.0
            config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            
            let session = URLSession(configuration: config)
            
            if (method == "GET" && params != nil) {
                var url = api! + "?"
                
                for (key,value) in params! {
                    url = url + "\(key as! String)=\(value)&"
                }
                
                request = NSMutableURLRequest(url: NSURL(string: (url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!))! as URL)
            } else if (method == "POST") {
                request.httpMethod = method!
                
                var data:Data! = Data()
                
                do {
                    if (params == nil) {
                        data = try JSONSerialization.data(withJSONObject:[], options:[])
                        request.httpBody = data
                    } else if (method == "POST") {
                        let boundary = generateBoundaryString()
                        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                        
                        let newParams = NSMutableDictionary()
                        newParams.setValue("", forKey: "")
                        newParams.setValue("", forKey: "")
                        newParams.setValue("", forKey: "")
                        
                        for (key,value) in params! {
                            newParams.setValue(value, forKey: key as! String)
                        }
                        
                        for (key, value) in newParams {
                            data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.ascii)!)
                            data.append("\(value)".data(using: String.Encoding.ascii)!)
                            data.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.ascii)!)
                        }
                        
                        if images != nil {
                            for i in 0..<(images?.count)! {
                                
                                let md = images?[i] as! NSMutableDictionary
                                
                                let param = md["param"] as! String
                                let image = md["image"] as! UIImage
                                
                                let image_data = UIImagePNGRepresentation(image)
                                
                                print("image-\(param)-\(image)-\(String(describing: image_data?.count))-")
                                
                                let fname = "test\(i).png"
                                
                                data.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                                data.append("Content-Disposition: form-data; name=\"\(param)\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
                                data.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                                data.append("Content-Type: application/octet-stream\r\n\r\n".data(using: String.Encoding.utf8)!)
                                
                                data.append(image_data!)
                                data.append("\r\n".data(using: String.Encoding.utf8)!)
                                
                                data.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
                            }
                        }
                        
                        request.httpBody = data
                    }
                } catch {
                    if ai {
                        stopActivityIndicator()
                    }
                    print("JSON serialization failed:  \(error)")
                }
                
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.addValue("\(data.count)", forHTTPHeaderField: "Content-Length")
            } else if (method == nil || params == nil || method == "GET") {
            }
            
            if header != nil {
                if (header?.count)! > 0 {
                    for (key,_) in header! {
                        request.setValue(header?.object(forKey: key) as? String, forHTTPHeaderField: "\(key)")
                    }
                }
            }
            
            var semaphore:DispatchSemaphore!
            
            if sync {
                semaphore = DispatchSemaphore(value: 0)
            }
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                
                let md = NSMutableDictionary()
                md["completionHandler"] = completionHandler
                
                if (data != nil) { md["data"] = data! as Data }
                if (response != nil) { md["response"] = response! as URLResponse }
                if (error != nil) {
                    md["error"] = error! as Error
                    
                    if ai {
                        self.stopActivityIndicator()
                    }
                }
                if (api != nil) { md["api"] = api! as String  }
                if (params != nil) { md["params"] = params! as NSMutableDictionary }
                if (method != nil) { md["method"] = method! as String }
                md["ai"] = ai as Bool
                md["popup"] = popup as Bool
                md["prnt"] = prnt as Bool
                
                if sync {
                    semaphore.signal()
                    self.jsonThread(md)
                } else {
                    self.performSelector(inBackground: #selector(self.jsonThread(_ :)), with: md)
                }
            });
            
            task.resume()
            
            if sync {
                _ = semaphore.wait(timeout: .distantFuture)
            }
        } else {
            if ai {
                stopActivityIndicator()
            }
            
            if popup {
                alert("Network message!", kInternetNotAvailable)
            }
            
            completionHandler (nil, params, "")
        }
    }
    
    @objc public func jsonThread(_ md:NSMutableDictionary) {
        let completionHandler = md["completionHandler"] as! ((NSDictionary?, NSMutableDictionary?, String) -> Swift.Void)
        
        var data:Data! = nil
        var response:URLResponse! = nil
        var error:Error! = nil
        var api:String! = nil
        var params:NSMutableDictionary! = nil
        
        if (md["data"] != nil) { data = md["data"] as? Data }
        if (md["response"] != nil) { response = md["response"] as? URLResponse }
        if (md["error"] != nil) { error = md["error"] as?Error }
        if (md["api"] != nil) { api = md["api"] as? String }
        if (md["params"] != nil) { params = md["params"] as? NSMutableDictionary }
        
        let ai = md["ai"] as! Bool
        let popup = md["popup"] as! Bool
        let prnt = md["prnt"] as! Bool
        
        var jsonString = ""
        
        if error != nil {
            if (api != nil) { print("api -\(api!)-") }
            if (params != nil) { print("params -\(params!)-") }
            if (error != nil) { print("error-\(error)-") }
            if (data != nil) {
                print("data -\(String(describing: NSString(data: data, encoding: String.Encoding.utf8.rawValue)))-")
                jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
            }
            
            if (response != nil) { print("response -\(response!)-") }
            
            if (popup) {
                self.alert("", kCouldnotconnect)
            }
            
            if (ai) {
                stopActivityIndicator ()
            }
            
            completionHandler(nil, params, jsonString)
        } else {
            do {
                let parsedData:NSDictionary? = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                
                if (prnt) {
                    if (api != nil) { print("api -\(api!)-") }
                    if (params != nil) { print("params -\(params!)-") }
                    if (parsedData != nil) { print("json -\(parsedData!)-") }
                }
                
                if (data != nil) {
                    jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
                }
                
                DispatchQueue.main.async {
                    completionHandler(parsedData, params, jsonString)
                }
            } catch _ as NSError {
                if (api != nil) { print("api -\(api!)-") }
                if (params != nil) { print("params -\(params!)-") }
                if (error != nil) { print(error) }
                if (data != nil) { print("data -\(String(describing: NSString(data: data, encoding: String.Encoding.utf8.rawValue)))-") }
                if (response != nil) { print("response -\(response!)-") }
                
                if (popup) {
                    self.alert("", kCouldnotconnect)
                }
                
                if ai {
                    stopActivityIndicator()
                }
                
                completionHandler(nil, params, jsonString)
            }
        }
        
        if (ai) {
            stopActivityIndicator ()
        }
    }
    
    public func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    open class func startActivityIndicator () {
        ActivityIndicator.sharedInstance.showActivityIndicator()
    }
    
    open class func stopActivityIndicator () {
        ActivityIndicator.sharedInstance.hideActivityIndicator()
    }
    
    public func startActivityIndicator () {
        //self.performSelector(inBackground: #selector(Http.startActivityIndicatorThread), with: nil)
        DispatchQueue.global().async {
            ActivityIndicator.sharedInstance.showActivityIndicator()
        }
    }
    
    public func stopActivityIndicator () {
        //self.performSelector(inBackground: #selector(Http.stopActivityIndicatorThread), with: nil)
        DispatchQueue.global().async {
            ActivityIndicator.sharedInstance.hideActivityIndicator()
        }
    }
    
    @objc open class func startActivityIndicatorThread () {
        ActivityIndicator.sharedInstance.showActivityIndicator()
    }
    
    @objc open class func stopActivityIndicatorThread () {
        DispatchQueue.main.async {
            ActivityIndicator.sharedInstance.hideActivityIndicator()
        }
    }
    
    public func attributedString() {
        /*
         // 1
         let string = "Don't have an account? SIGN UP NOW!" as NSString
         
         //let string = "Testing Attributed Strings" as NSString
         var attributedString = NSMutableAttributedString(string: string as String)
         
         // 2
         let firstAttributes = [NSForegroundColorAttributeName: UIColor.blue, NSBackgroundColorAttributeName: UIColor.yellow, NSUnderlineStyleAttributeName: 1] as [String : Any]
         let secondAttributes = [NSForegroundColorAttributeName: UIColor.red,
         NSBackgroundColorAttributeName: UIColor.blue,
         NSStrikethroughStyleAttributeName: 1] as [String : Any]
         let thirdAttributes = [NSForegroundColorAttributeName: UIColor.green, NSBackgroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 40)]
         
         // 3
         //attributedString.addAttributes(firstAttributes, range: string.range(of: "Testing"))
         attributedString.addAttributes(secondAttributes, range: string.range(of: "SIGN UP NOW!"))
         //attributedString.addAttributes(thirdAttributes, range: string.range(of: "Strings"))
         
         // 4
         //myTestLabel.attributedText = attributedString
         */
    }
    
    open class func alert (_ ttl:String?, _ msg:String?) {
        if (msg != nil) {
            if (msg?.count)! > 0 {
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate
                    
                    let alertController:UIAlertController
                    
                    var ttl = ttl
                    
                    if (ttl == nil) {
                        ttl = ""
                    }
                    
                    alertController = UIAlertController(title: ttl, message: msg, preferredStyle: .alert)
                    
                    let defaultActionq = UIAlertAction(title: "Ok", style: .default, handler: { (_ action:UIAlertAction) in
                        
                    })
                    
                    alertController.addAction(defaultActionq)
                    
                    appDelegate?.window??.rootViewController?.present(alertController, animated: true, completion: { })
                }
            }
        }
    }
    
    public func alert (_ ttl:String?, _ msg:String?) {
        Http.alert(ttl, msg)
    }
    
    open class func alert (_ ttl:String?, _ msg:String?, _ btns:[Any]) {
        if (msg != nil) {
            if (msg?.count)! > 0 {
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate
                    
                    let alertController:UIAlertController
                    
                    var ttl = ttl
                    
                    if (ttl == nil) {
                        ttl = ""
                    }
                    
                    alertController = UIAlertController(title: ttl, message: msg, preferredStyle: .alert)
                    
                    if btns.count >= 2 {
                        alertController.addAction(self.alertAction(btns, 0))
                    }
                    
                    if btns.count >= 3 {
                        alertController.addAction(self.alertAction(btns, 1))
                    }
                    
                    appDelegate?.window??.rootViewController?.present(alertController, animated: true, completion: { })
                }
            }
        }
    }
    
    open class func alertFailed (title:NSString?, _ json:NSDictionary?, _ key:String) {
        let message = json?[key] as! String!
        
        var title = title
        
        if title == nil {
            title = ""
        }
        
        if !(message == "failed." || message == "Validation failed") {
            Http.alert(title as String?, json?[key] as! String!)
        } else {
            if let result = json?["result"] as? NSDictionary {
                var msg = ""
                
                let arr = result.allKeys
                
                for i in 0..<arr.count {
                    let key = arr[i] as? String
                    
                    if let keyArr = result[key!] as? NSArray {
                        for j in 0..<keyArr.count {
                            msg = keyArr[j] as! String
                            Http.alert(title as String?, msg)
                        }
                    }
                }
            }
        }
    }
    
    open class func alertAction (_ btns:[Any], _ index:Int) -> UIAlertAction {
        let action = UIAlertAction(title: (btns[index + 1] as? String)!, style: .default, handler: { (_ action:UIAlertAction) in
            
            let vc = btns[0] as? AlertDelegate
            
            if index == 0 {
                vc?.alertZero()
            } else if index == 1 {
                vc?.alertOne()
            }
        })
        
        return action
    }
}

protocol AlertDelegate {
 func alertZero ()
 func alertOne ()
}

open class ImageView: UIImageView {
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
    
    var shadowLayer: CAShapeLayer!
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if isShadow {
            if shadowLayer == nil {
                let color = self.backgroundColor
                self.backgroundColor = UIColor.clear
                
                shadowLayer = CAShapeLayer()
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(radious)).cgPath
                shadowLayer.fillColor = color?.cgColor
                
                shadowLayer.shadowColor = shadow_Color?.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: lsOff_Width, height: lsOff_Height)
                shadowLayer.shadowOpacity = Float(ls_Opacity)
                shadowLayer.shadowRadius = CGFloat(ls_Radius)
                
                layer.insertSublayer(shadowLayer, at: 0)
            }
        } else if isBorder {
            border1(borderColor, CGFloat(radious), CGFloat(border))
        }
    }
    
    public func border1 (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
    
    var url:[String] = []
    
    @IBInspectable open var willZoom: Bool = false
    @IBInspectable open var background_color: UIColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
    
    override open func draw(_ rect: CGRect) {
        setUIImage ()
        
        if willZoom {
            addClickButton (rect)
        }
        
        if isStrokeColor {
            let c = UIGraphicsGetCurrentContext()
            c!.addRect(CGRect(x: 10.0, y: 10.0, width: 80.0, height: 80.0))
            c!.setStrokeColor(UIColor.red.cgColor)
            c!.strokePath()
        }
    }
    
    var urlImage:String? = nil
    var dImage:String? = nil
    var boolScal:Bool = false
    var ai:UIActivityIndicatorView? = nil
    var superView:UIView? = nil
    
    public func setImage(_ superView:UIView?, _ urlImage:String?, _ dImage:String?, _ boolScal:Bool, _ ai:UIActivityIndicatorView?) {
        draw (self.frame)
        
        self.superView = superView
        self.urlImage = urlImage
        self.dImage = dImage
        self.boolScal = boolScal
        self.ai = ai
        
        setUIImage ()
    }
    
    public func createZoomView (_ superView:UIView?) {
        if willZoom {
            DispatchQueue.main.async {
                self.superView = superView
                self.addClickButton (self.frame)
            }
        }
    }
    
    public func setUIImage () {
        if urlImage != nil {
            self.uiimage(urlImage, dImage, boolScal, ai)
        }
    }
    
    var btnOpen:UIButton? = nil
    
    public func addClickButton (_ rect: CGRect) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_ :)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc public func imageTapped (_ tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        openZoomView(tappedImage)
    }
    
    public func openZoomView (_ sender:Any) {
        if viewZoomContainer == nil {
            viewZoomContainer = UIView()
            viewZoomContainer?.frame = UIScreen.main.bounds
            viewZoomContainer?.isUserInteractionEnabled = true
            
            viewZoomContainer?.backgroundColor = background_color
            
            if scZoom == nil {
                scZoom = UIScrollView()
                scZoom?.frame = UIScreen.main.bounds
                scZoom?.isUserInteractionEnabled = true
                viewZoomContainer?.addSubview(scZoom!)
            }
            
            if imgZoom == nil {
                imgZoom = UIImageView()
                imgZoom?.isUserInteractionEnabled = true
                
                if scZoom != nil {
                    scZoom?.addSubview(imgZoom!)
                    addPichZoom ()
                }
            }
            
            if btnRemoveZoomaContainer == nil {
                let frame = CGRect(x: 0.0, y: 10.0, width: 50, height: 50)
                btnRemoveZoomaContainer = UIButton(frame: frame)
                btnRemoveZoomaContainer?.setTitle("X", for: UIControlState.normal)
                btnRemoveZoomaContainer?.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                btnRemoveZoomaContainer?.setTitleColor(UIColor.red, for: UIControlState.normal)
                
                btnRemoveZoomaContainer?.addTarget(self, action: #selector(actionRemoveZoomContainer (_ :)), for: UIControlEvents.touchUpInside)
                
                viewZoomContainer?.addSubview(btnRemoveZoomaContainer!)
            }
            
            DispatchQueue.main.async {
                let image = self.image
                
                if image != nil {
                    
                    self.imgZoom?.image = image
                    
                    let size = getImageSize((image?.size)!)
                    
                    var frame = self.imgZoom?.frame
                    frame?.origin.x = (self.viewZoomContainer?.frame.size.width)! / 2 - size.width / 2
                    frame?.origin.y = (self.viewZoomContainer?.frame.size.height)! / 2 - size.height / 2
                    frame?.size.width = size.width
                    frame?.size.height = size.height
                    self.imgZoom?.frame = frame!
                    self.frameImage = frame
                }
            }
        } else {
            if frameImage != nil {
                self.imgZoom?.frame = frameImage!
                
                makeInCenter ()
            }
        }
        
        superView?.addSubview(viewZoomContainer!)
    }
    
    var frameImage:CGRect? = nil
    
    @IBOutlet var scZoom: UIScrollView? = nil
    var viewZoomContainer: UIView? = nil
    var imgZoom: UIImageView? = nil
    var twoFingerPinch:UIPinchGestureRecognizer? = nil
    
    var superClass:Any? = nil
    
    @IBOutlet var btnRemoveZoomaContainer:UIButton? = nil
    
    @IBAction public func actionRemoveZoomContainer(_ sender: Any) {
        viewZoomContainer?.removeFromSuperview()
    }
    
    public func addPichZoom () {
        twoFingerPinch = UIPinchGestureRecognizer(target: self, action: #selector(self.twoFingerPinch(_ :)))
        imgZoom?.addGestureRecognizer(twoFingerPinch!)
    }
    
    @objc public func twoFingerPinch (_ recognizer:UIPinchGestureRecognizer) {
        let scale: CGFloat = recognizer.scale;
        
        imgZoom?.transform = (imgZoom?.transform.scaledBy(x: scale, y: scale))!;
        recognizer.scale = 1.0;
        
        makeInCenter ()
    }
    
    func makeInCenter () {
        var width = viewZoomContainer?.frame.size.width
        var height = viewZoomContainer?.frame.size.height
        
        if (imgZoom?.frame.size.width)! > (viewZoomContainer?.frame.size.width)! && (imgZoom?.frame.size.height)! > (viewZoomContainer?.frame.size.height)! {
            width = imgZoom?.frame.size.width
            height = imgZoom?.frame.size.height
        } else if (imgZoom?.frame.size.width)! > (viewZoomContainer?.frame.size.width)! {
            width = imgZoom?.frame.size.width
        } else if (imgZoom?.frame.size.height)! > (viewZoomContainer?.frame.size.height)! {
            height = imgZoom?.frame.size.height
        }
        
        scZoom?.contentSize = CGSize(width:width!, height:height!)
        
        imgZoom?.center = CGPoint(x: (scZoom?.contentSize.width)! / 2, y: (scZoom?.contentSize.height)! / 2)
        scZoom?.contentOffset = CGPoint(x: (imgZoom?.center.x)! - (scZoom?.frame.size.width)! / 2, y: (imgZoom?.center.y)! - (scZoom?.frame.size.height)! / 2)
    }
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

 public extension NSArray {
    public func convertToString () -> String {
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
    
    public func convertToString (_ caller:Bool = true)  -> String {
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
                    str = "\(str)\(val.convertToString(false))"
                } else if let val = self[i] as? NSDictionary {
                    str = "\(str)\(val.convertToString(false))"
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
                    str = "\(str),\(val.convertToString(false))"
                } else if let val = self[i] as? NSDictionary {
                    str = "\(str),\(val.convertToString(false))"
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
        //self.prefix(1)
        /*let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other*/
        
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
        
        let timeZoneLocal = NSTimeZone.local as TimeZone!
        
        let newDate = Date(timeInterval: TimeInterval((timeZoneLocal?.secondsFromGMT(for: dateUTC))!), since: dateUTC)
        
        return newDate.getStringDate(formate)
    }
}

 public extension UIView {
    
    public func border (_ color:UIColor?, _ cornerRadius:CGFloat, _ borderWidth:CGFloat) {
        self.layer.masksToBounds = true
        if (color != nil) { self.layer.borderColor = color?.cgColor }
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
    
    public func shadowSubViews () {
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
        
        // add the border to subview
        let borderView = UIView()
        borderView.frame = self.bounds
        borderView.layer.cornerRadius = 10
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.borderWidth = 1.0
        borderView.layer.masksToBounds = true
        self.addSubview(borderView)
        
        // add any other subcontent that you want clipped
        let otherSubContent = UIImageView()
        //otherSubContent.image = UIImage(named: "lion")
        otherSubContent.frame = borderView.bounds
        borderView.addSubview(otherSubContent)
    }
    
    public func shadow () {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = self.frame.size.height/4.0
        self.layer.masksToBounds = false
    }
}

 public extension UIImage {
    public func resize(_ wth: CGFloat) -> UIImage {
        
        let scale = wth / self.size.width
        let newHeight = self.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: wth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: wth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    public func base64 (_ quality:CGFloat) -> String {
        /*let imgD1:Data?  = UIImageJPEGRepresentation(self, quality)! as Data
         let img1:UIImage = UIImage(data: imgD1!)!*/
        let imageData:NSData = UIImagePNGRepresentation(self)! as NSData
        
        let bytes = Double(imageData.length)/8.0
        let kb = bytes/1024.0
        let mb = kb/1024.0
        
        print("imageData size-\(kb)-\(mb)-")
        
        let profilePicture = imageData.base64EncodedString(options: .lineLength64Characters)
        
        return profilePicture
    }
}

 public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    public class func hexColor(rgbValue:UInt32, alpha:Double=1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}

 public extension Date {
    /// Returns the amount of years from another date
    public func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    public func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    public func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    public func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    public func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    public func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    public func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    public func all(from date: Date) -> DateComponents {
        //print("self-\(self)-")
        //print("date-\(date)-")
        return Calendar.current.dateComponents([.year, .month, .hour, .day, .minute, .second], from: date, to: self)
        
        //return Calendar.current.dateComponents([.year, .month, .hour, .day, .minute, .second], from: date, to: self).second ?? 0
    }
    
    /// Returns the a custom time interval description from another date
    public func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    public func getStringDate(_ formate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.string(from: self)
    }
}

 public extension UIImageView {
    public func saveImageDocumentDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.jpg")
        let image = UIImage(named: "apple.jpg")
        print(paths)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    public func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    public func getImage () -> UIImage? {
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("apple.jpg")
        
        if fileManager.fileExists(atPath: imagePAth) {
            return UIImage(contentsOfFile: imagePAth)
        } else {
            return nil
        }
    }
    
    public func createDirectory() {
        let fileManager = FileManager.default
        
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("customDirectory")
        
        if !fileManager.fileExists(atPath: paths) {
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        } else {
            print("Already dictionary created.")
        }
    }
    
    public func deleteDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("customDirectory")
        
        if !fileManager.fileExists(atPath: paths) {
            try! fileManager.removeItem(atPath: paths)
        } else {
            print("Something wronge.")
        }
    }
    
    public func deleteFileForUrl (_ url:String?) {
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(url!.imageName())
        
        let del:Bool = fileManager.fileExists(atPath: imagePAth)
        
        if del {
            try! fileManager.removeItem(atPath: imagePAth)
        } else {
            print("Something wronge.")
        }
    }
    
    public func savedUIImageForUrl (_ url:String, block: @escaping (UIImage?) -> Swift.Void) {
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(url.imageName())
        
        if fileManager.fileExists(atPath: imagePAth) {
            block(UIImage(contentsOfFile: imagePAth))
        } else {
            block(nil)
        }
    }
    
    public func savedUIImage (_ name:String?, block: @escaping (UIImage?) -> Swift.Void) {
        
        if (name == nil) {
            block(nil)
        } else {
            let fileManager = FileManager.default
            let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(name!)
            
            if fileManager.fileExists(atPath: imagePAth) {
                block(UIImage(contentsOfFile: imagePAth))
            } else {
                block(nil)
            }
        }
    }
    
    public func saveUIImage (_ name:String?, _ img:UIImage?) {
        if (name != nil && img != nil) {
            let data:Data? = UIImagePNGRepresentation(img!)!
            
            if (data != nil) {
                let fileManager = FileManager.default
                let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name!)
                
                fileManager.createFile(atPath: paths as String, contents: data, attributes: nil)
            }
        }
    }
    
    public func saveUIImageForUrl (_ url:String?, _ img:UIImage?) {
        if (url != nil && img != nil) {
            let data:Data? = UIImagePNGRepresentation(img!)!
            
            if (data != nil) {
                let fileManager = FileManager.default
                let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(url!.imageName())
                
                fileManager.createFile(atPath: paths as String, contents: data, attributes: nil)
            }
        }
    }
    
    @objc public func displayImage (_ dict:NSDictionary) {
        let boolCustomScale:Bool = dict["scale"] as! Bool
        
        if (boolCustomScale) {
            self.clipsToBounds = true;
            self.contentMode = .scaleAspectFill
        }
        
        let url:String = dict["url"] as! String
        
        let imgV = self as? ImageView
        
        if imgV != nil {
            let superView = dict["superView"] as? UIView
            
            if (imgV?.url.count)! > 0 {
                if imgV != nil {
                    
                    let imageUrl = imgV?.url[(imgV?.url.count)!-1]
                    
                    if imageUrl != nil {
                        if imageUrl! == url {
                            if let img = dict["image"] as? UIImage {
                                self.image = img
                                imgV?.createZoomView(superView)
                            } else if let dimg = dict["dimage"] as? String {
                                self.image = UIImage(named: dimg)
                            }
                        }
                    }
                } else {
                    if let img = dict["image"] as? UIImage {
                        self.image = img
                        imgV?.createZoomView(superView)
                    } else if let dimg = dict["dimage"] as? String {
                        self.image = UIImage(named: dimg)
                    }
                }
            }
        } else {
            if let img = dict["image"] as? UIImage {
                self.image = img
            } else if let dimg = dict["dimage"] as? String {
                self.image = UIImage(named: dimg)
            }
        }
        
        if let ai = dict["ai"] as? UIActivityIndicatorView {
            ai.isHidden = true
            ai.stopAnimating()
        }
    }
    
    public func downloadUIImage (_ url:String?, block: @escaping (UIImage?) -> Swift.Void) {
        let md = NSMutableDictionary()
        md["url"] = url
        md["block"] = block
        
        self.performSelector(inBackground: #selector(downloadUIImageThread (_ :)), with: md)
    }
    
    @objc public func downloadUIImageThread (_ md:NSMutableDictionary) {
        let url:String? = md["url"] as? String
        let block = md["block"] as! (UIImage?) -> Swift.Void
        
        self.savedUIImageForUrl(url!, block: { (img) in
            if (img != nil) {
                block(img)
            } else {
                let urlL = URL(string: (url?.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!)!)!
                
                let data = NSData(contentsOf: urlL as URL) as Data?
                
                var image:UIImage? = nil;
                
                if (data != nil) {
                    image = UIImage(data: data! as Data)
                    
                    if (image != nil) {
                        self.saveUIImageForUrl(url, image)
                    }
                } else {
                    self.deleteFileForUrl(url)
                }
                
                block(image)
            }
        })
    }
    
    public func uiimage (_ url:String?, _ dImage:String?, _ boolScal:Bool, _ ai:UIActivityIndicatorView?, _ superView:UIView? = nil) {
        if url != nil {
            if ((url?.count)! > 0 && url != "") {
                savedUIImageForUrl(url!, block: { (image) in
                    if image != nil {
                        self.image = image
                        
                        if superView != nil {
                            let imgV = self as? ImageView
                            
                            if imgV != nil {
                                imgV?.createZoomView(superView)
                            }
                        }
                    } else {
                        self.image = UIImage()
                        
                        if self is ImageView {
                            let iiii = self as? ImageView
                            iiii?.url.append(url!)
                        }
                        
                        if ai != nil {
                            ai?.isHidden = false
                            ai?.startAnimating()
                        }
                        
                        var dImage = dImage
                        
                        if (dImage == nil) {
                            dImage = "noimage.jpg";
                        } else if (dImage?.count == 0) {
                            dImage = "noimage.jpg";
                        }
                        
                        let url = url?.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
                        
                        let dict = NSMutableDictionary()
                        
                        dict["url"] = url
                        dict["scale"] = boolScal
                        
                        if ai != nil {
                            dict["ai"] = ai;
                        }
                        
                        dict["dimage"] = dImage
                        
                        if superView != nil {
                            dict["superView"] = superView
                        }
                        
                        self.performSelector(inBackground: #selector(self.getNSetUIImagee(_ :)), with: dict)
                    }
                })
            } else {
                self.image = UIImage(named: dImage!)
                
                if superView != nil {
                    let imgV = self as? ImageView
                    
                    if imgV != nil {
                        imgV?.createZoomView(superView)
                    }
                }
                
                if ai != nil {
                    ai?.isHidden = true
                    ai?.stopAnimating()
                }
            }
        }
    }
    
    @objc public func getNSetUIImagee (_ dict:NSDictionary) {
        let url:String = dict["url"] as! String
        
        self.downloadUIImage(url) { (image) in
            let dt = NSMutableDictionary()
            
            for (key, value) in dict {
                dt[key] = value
            }
            
            if (image != nil) {
                dt["image"] = image
            }
            
            if let superView = dict["superView"] as? UIView {
                dt["superView"] = superView
            }
            
            self.performSelector(inBackground: #selector(self.displayImage(_:)), with: dt)
        }
    }
}

 public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
    public func deviceInfo (_ md:NSMutableDictionary?) {
        if md != nil {
            md?["os_type"] = "ios"
            
            let iosVersion = UIDevice.current.systemVersion
            
            md?["os_version"] = iosVersion
            
            let nsObject: NSDictionary? = Bundle.main.infoDictionary as NSDictionary?
            
            md?["app_version"] = ""
            md?["app_build"] = ""
            
            if nsObject != nil {
                if let version = nsObject?.object(forKey: "CFBundleShortVersionString") as? String {
                    md?["app_version"] = "\(version)"
                }
                
                if let build = nsObject?.object(forKey: "CFBundleVersion") as? String {
                    md?["app_build"] = "\(build)"
                }
            }
            
            md?["device_name"] = UIDevice.current.modelName
            md?["identifierForVendor"] = identifierForVendor ()
        }
    }
    
    func identifierForVendor () -> String {
        var venderUdid = UIDevice.current.identifierForVendor!.uuidString
        
        let ob = StoreToDevice()
        
        let data = ob.getStoredData()
        
        var boolAddNewDevice = true
        
        if data != nil {
            if (data?.count)! > 0 {
                boolAddNewDevice = false
                
                venderUdid = data!
            }
        }
        
        if boolAddNewDevice {
            ob.setDeviceStoredData(venderUdid)
        }
        
        return venderUdid
    }
}

public func getImageSize (_ size:CGSize) -> CGSize {
    var width = size.width
    var height = size.height
    
    if size.width > UIScreen.main.bounds.width {
        width = UIScreen.main.bounds.width
        
        let scale = width / size.width
        height = size.height * scale
    } else if size.height > UIScreen.main.bounds.height {
        height = UIScreen.main.bounds.height
        
        let scale = height / size.height
        width = size.width * scale
    }
    
    return CGSize(width:width, height:height)
}

public func filterByPrice (_ ma:NSMutableArray,_ high:Bool) -> NSMutableArray {
    class Item: NSObject {
        var price:Double = 0.0
    }

    var swiftArray = ma as NSArray as! [Item]
    
    if high {
        swiftArray = swiftArray.sorted { $0.price < $1.price }
    } else {
        swiftArray = swiftArray.sorted { $0.price > $1.price }
    }
    
    return NSMutableArray(array: swiftArray)
}

public func array (_ dict:NSDictionary, _ key:String) -> Array<Any>? {
    if let title = dict[key] as? Array<Any> {
        return title
    } else {
        return nil
    }
}

public func dictionary (_ dict:NSDictionary, _ key:String) -> Dictionary<String, Any>? {
    if let title = dict[key] as? Dictionary<String, Any> {
        return title
    } else {
        return nil
    }
}

public func string (_ dict:NSDictionary, _ key:String) -> String {
    if let title = dict[key] as? String {
        return "\(title)"
    } else if let title = dict[key] as? NSNumber {
        return "\(title)"
    } else {
        return ""
    }
}

public func number (_ dict:NSDictionary, _ key:String) -> NSNumber {
    if let title = dict[key] as? NSNumber {
        return title
    } else if let title = dict[key] as? String {
        
        if let title1 = Int(title) as Int? {
            return NSNumber(value: title1)
        } else if let title1 = Float(title) as Float? {
            return NSNumber(value: title1)
        } else if let title1 = Double(title) as Double? {
            return NSNumber(value: title1)
        } else if let title1 = Bool(title) as Bool? {
            return NSNumber(value: title1)
        }
        
        return 0
    } else {
        return 0
    }
}

public func bool (_ dict:NSDictionary, _ key:String) -> Bool {
    if let title = dict[key] as? Bool {
        return title
    } else {
        return false
    }
}

public func niil (_ dict:NSDictionary, _ key:String) -> String? {
    if let title = dict[key] as? String {
        return title
    } else {
        return nil
    }
}

public func nullToNil(value : AnyObject?) -> AnyObject? {
    if value is NSNull {
        return nil
    } else {
        return value
    }
}

public func null(value : AnyObject?) -> Bool {
    if value == nil {
        return false
    } else if value is NSNull {
        return false
    } else {
        return true
    }
}

public func callNumber(_ phoneNumber:String) {
    if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
        
        if (application.canOpenURL(phoneCallURL as URL)) {
            //application.openURL(phoneCallURL as URL);
            application.open(phoneCallURL as URL, options: [:], completionHandler: nil)
        } else {
            Http.alert("", "Phone call not available.")
        }
    } else {
        Http.alert("", "Phone call not available.")
    }
}

public func getAddressOrLatLong (_ lat:NSNumber?, _ long:NSNumber?, _ addr:String?, _ prnt:Bool) -> (lat:String?, long:String?, address:String?) {
    let reach = Reachability.init(hostname: "google.com")
    
    if prnt {
        print("lat-\(String(describing: lat))-")
        print("long-\(String(describing: long))-")
        print("addr-\(String(describing: addr))-")
    }
    
    if lat == nil && long == nil && addr == nil {
        return (nil, nil, nil)
    } else {
        if (reach?.isReachable)! {
            var api = "https://maps.google.com/maps/api/geocode/json?sensor=false&"
            
            if lat != nil && long != nil {
                api = api + "latlng=\(lat!),\(long!)"
            } else if addr != nil {
                api = api + "address=\(addr!)"
            }
            
            if prnt {
                print("api-\(api)-")
            }
            
            do {
                let data = NSData(contentsOf: URL(string: api)!)
                
                if data != nil {
                    let json:NSDictionary? = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as? NSDictionary
                    
                    if prnt {
                        print("json-\(String(describing: json))-")
                    }
                    
                    if json != nil {
                        
                        if json != nil {
                            let status = string(json!, "status")
                            
                            if status == "OK" {
                                if let results = json?["results"] as? NSArray {
                                    for i in 0..<results.count {
                                        if lat != nil && long != nil {
                                            if let dt = results[i] as? NSDictionary {
                                                let address = string(dt, "formatted_address")
                                                
                                                return (nil, nil, address)
                                            }
                                        } else if addr != nil {
                                            if let dt = results[i] as? NSDictionary {
                                                if let geometry = dt["geometry"] as? NSDictionary {
                                                    if let location = geometry["location"] as? NSDictionary {
                                                        let lat = string(location, "lat")
                                                        let lng = string(location, "lng")
                                                        
                                                        if lat.count > 0 && lng.count > 0 {
                                                            return (lat, lng, nil)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                        break
                                    }
                                }
                            }
                        }
                    }
                }
            } catch _ as NSError {
            }
        }
    }
    
    return (nil, nil, nil)
}

func langUI (_ view:UIView?) {
    if view != nil {
        if view?.superview != nil {
            var frame1 = view!.frame
            frame1.origin.x = CGFloat((view?.superview?.frame.size.width)! - frame1.size.width - frame1.origin.x)
            view?.frame = frame1
        }
        
        for vv in (view?.subviews)! {
            if vv.tag == 100 {
                continue
            }
            
            if vv is UIScrollView {
                langUI(vv)
            } else if vv is UILabel
                || vv is UITextField
                || vv is UITextView
                || vv is UIButton
                //|| vv is UIScrollView
                || vv is UITableView
                || vv is UITableViewCell
                || vv is UIImageView
                || vv is UISlider
                || vv is UISearchBar
                || vv is UIActivityIndicatorView
                || vv is UISwitch
                || vv is UISegmentedControl
                || vv is UIProgressView
                || vv is UIPageControl
                || vv is UIStepper
                || vv is UICollectionView
                || vv is UICollectionViewCell
                || vv is UIDatePicker
                || vv is UIPickerView
                || vv is UIWebView
                || vv is UINavigationBar
                || vv is UIToolbar
                || vv is UITabBar
                || vv is MKMapView
            {
                if view is UIScrollView {
                    let view = view as! UIScrollView
                    var frame = vv.frame
                    frame.origin.x = view.contentSize.width - frame.size.width - frame.origin.x
                    vv.frame = frame
                } else {
                    var frame = vv.frame
                    frame.origin.x = (view?.frame.size.width)! - frame.size.width - frame.origin.x
                    vv.frame = frame
                }
                
                if vv is UILabel {
                    let vv = vv as! UILabel
                    
                    if vv.textAlignment == .left || vv.textAlignment == .natural {
                        vv.textAlignment = .right
                    } else if vv.textAlignment == .right {
                        vv.textAlignment = .left
                    }
                } else if vv is UITextField {
                    let vv = vv as! UITextField
                    
                    if vv.textAlignment == .left || vv.textAlignment == .natural {
                        vv.textAlignment = .right
                    } else if vv.textAlignment == .right {
                        vv.textAlignment = .left
                    }
                } else if vv is UITextView {
                    let vv = vv as! UITextView
                    
                    if vv.textAlignment == .left || vv.textAlignment == .natural {
                        vv.textAlignment = .right
                    } else if vv.textAlignment == .right {
                        vv.textAlignment = .left
                    }
                }
            } else {
                langUI(vv)
            }
        }
    }
}




