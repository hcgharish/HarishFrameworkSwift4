//
//  Http.swift
//  SupportingProject
//
//  Created by Harish on 16/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

let kCouldnotconnect = "Could not connect to the server. Please try again later."
let kInternetNotAvailable = "Please establish network connection."

open class Http: NSObject {
    open class func instance () -> Http {
        return Http()
    }
    
    public func json (_ api:String?,_ params:NSMutableDictionary?, _ method:String?, ai:Bool, popup:Bool, prnt:Bool, _ header:NSDictionary? = nil , _ images:NSMutableArray? = nil, sync:Bool = false, completionHandler: @escaping (Any?, NSMutableDictionary?, String) -> Swift.Void) {
        
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
        let completionHandler = md["completionHandler"] as! ((Any?, NSMutableDictionary?, String) -> Swift.Void)
        
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
            var prnt = "====================================================================="
            
            if (api != nil) { prnt += "\n" + "api -\(api!)-" }
            if (params != nil) { prnt += "\n" + "params -\(params!)-" }
            if (error != nil) { prnt += "\n" + "error-\(error)-" }
            if (data != nil) {
                prnt += "\n" + "data -\(String(describing: NSString(data: data, encoding: String.Encoding.utf8.rawValue)))-"
                jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
            }
            
            if (response != nil) { prnt += "\n" + "response -\(response!)-" }
            
            prnt += "\n" + "====================================================================="
            
            print(prnt)
            
            if (popup) {
                self.alert("", kCouldnotconnect)
            }
            
            if (ai) {
                stopActivityIndicator ()
            }
            
            completionHandler(nil, params, jsonString)
        } else {
            do {
                var parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                
                if let output = parsedData as? NSDictionary  {
                    parsedData = output.getMutable(nil) ?? (Any).self
                } else if let output = parsedData as? NSArray {
                    parsedData = output.getMutable(nil) ?? (Any).self
                } else if let output = parsedData as? NSMutableDictionary {
                    parsedData = output.getMutable(nil) ?? (Any).self
                } else if let output =  parsedData as? NSMutableArray {
                    parsedData = output.getMutable(nil) ?? (Any).self
                }
                
                if (prnt) {
                    var prnt = "====================================================================="
                    if (api != nil) { prnt += "\n" + "api -\(api!)-" }
                    if (params != nil) { prnt += "\n" + "params -\(params!)-" }
                    if (parsedData != nil) { prnt += "\n" + "json -\(parsedData)-" }
                    
                    prnt += "\n" + "====================================================================="
                    
                    print(prnt)
                }
                
                if (data != nil) {
                    jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
                }
                
                DispatchQueue.main.async {
                    completionHandler(parsedData, params, jsonString)
                }
            } catch _ as NSError {
                var prnt = "====================================================================="
                if (api != nil) { prnt += "\n" + "api -\(api!)-" }
                if (params != nil) { prnt += "\n" + "params -\(params!)-" }
                if (error != nil) { prnt += "\n\(error)" }
                if (data != nil) { prnt += "\n" + "data -\(String(describing: NSString(data: data, encoding: String.Encoding.utf8.rawValue)))-" }
                if (response != nil) { prnt += "\n" + "response -\(response!)-" }
                
                prnt += "\n" + "====================================================================="
                
                print(prnt)
                
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
        DispatchQueue.global().async {
            ActivityIndicator.sharedInstance.showActivityIndicator()
        }
    }
    
    public func stopActivityIndicator () {
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
                    //alertController.alert.title.preferredStyle.
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
