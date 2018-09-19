//
//  Functions.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/07/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit
import MapKit

public protocol AlertDelegate {
    func alertZero ()
    func alertOne ()
}

class Functions: NSObject { }

public func getImageSizeByUIScreen (_ size:CGSize) -> CGSize {
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
    return CGSize(width:width,height:height)
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

public func array (_ dict:NSDictionary,_ key: String) -> Array<Any>? {
    if let title = dict[key] as? Array<Any> {
        return title
    } else {
        return nil
    }
}

public func dictionary (_ dict:NSDictionary,_ key: String) -> Dictionary<String,Any>? {
    if let title = dict[key] as? Dictionary<String,Any> {
        return title
    } else {
        return nil
    }
}

public func string (_ dict:NSDictionary,_ key: String) -> String {
    if let title = dict[key] as? String {
        return "\(title)"
    } else if let title = dict[key] as? NSNumber {
        return "\(title)"
    } else {
        return ""
    }
}

public func number (_ dict:NSDictionary,_ key: String) -> NSNumber {
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

public func bool (_ dict:NSDictionary,_ key: String) -> Bool {
    if let title = dict[key] as? Bool {
        return title
    } else {
        return false
    }
}

public func niil (_ dict:NSDictionary,_ key: String) -> String? {
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

public func isNull(value : AnyObject?) -> Bool {
    if value == nil {
        return true
    } else if value is NSNull {
        return true
    } else {
        return false
    }
}

public func callNumber(_ phoneNumber: String) {
    if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
            //application.openURL(phoneCallURL as URL);
            if #available(iOS 10.0,*) {
                application.open(phoneCallURL as URL,options: [:],completionHandler: nil)
            } else {
                // Fallback on earlier versions
                application.openURL(phoneCallURL as URL)
            }
        } else {
            Http.alert("","Phone call not available.")
        }
    } else {
        Http.alert("","Phone call not available.")
    }
}

public func getAddressOrLatLong (_ lat:NSNumber?,_ long:NSNumber?,_ addr:String?,_ prnt:Bool) -> (lat:String?,long:String?,address:String?) {
    let reach = Reachability.init(hostname: "google.com")
    if prnt {
        print("lat-\(String(describing: lat))-")
        print("long-\(String(describing: long))-")
        print("addr-\(String(describing: addr))-")
    }
    if lat == nil && long == nil && addr == nil {
        return (nil,nil,nil)
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
                    let json:NSDictionary? = try JSONSerialization.jsonObject(with: data! as Data,options: .allowFragments) as? NSDictionary
                                    if prnt {
                        print("json-\(String(describing: json))-")
                    }
                                    if json != nil {
                                            if json != nil {
                            let status = string(json!,"status")
                                                    if status == "OK" {
                                if let results = json?["results"] as? NSArray {
                                    for i in 0..<results.count {
                                        if lat != nil && long != nil {
                                            if let dt = results[i] as? NSDictionary {
                                                let address = string(dt,"formatted_address")
                                                                                            return (nil,nil,address)
                                            }
                                        } else if addr != nil {
                                            if let dt = results[i] as? NSDictionary {
                                                if let geometry = dt["geometry"] as? NSDictionary {
                                                    if let location = geometry["location"] as? NSDictionary {
                                                        let lat = string(location,"lat")
                                                        let lng = string(location,"lng")
                                                                                                            if lat.count > 0 && lng.count > 0 {
                                                            return (lat,lng,nil)
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
    return (nil,nil,nil)
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








