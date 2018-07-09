//
//  Comman.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit
import MapKit

public protocol AlertDelegate {
    func alertZero ()
    func alertOne ()
}

open class MyRouteObject: NSObject {
    var coords:NSMutableArray!
    var count1:Int = 0;
    
    override init() {
        super.init()
    }
}

open class Comman: NSObject {
    public func polylineWithEncodedString(_ encodedString:String) -> MKPolyline {
        let bytes = encodedString.utf8CString
        let length = encodedString.lengthOfBytes(using: .utf8)
        
        var idx = 0;
        
        var count = length / 4;
        
        var coords:[CLLocationCoordinate2D] = [CLLocationCoordinate2D]();
        
        var coordIdx = 0;
        
        var latitude = 0.0;
        var longitude = 0.0;
        
        while (idx < length) {
            var byte:Int
            var res:Int = 0
            var shift:Int = 0
            
            repeat {
                byte = bytes[idx].hashValue - 63;
                res |= (byte & 0x1F) << shift;
                shift += 5;
                
                idx += 1
            } while (byte >= 0x20);
            
            let deltaLat = Double(((res % 2) == 1) ? ~(res >> 1) : res >> 1);
            
            latitude += deltaLat;
            
            shift = 0;
            res = 0;
            
            repeat {
                byte = bytes[idx].hashValue - 0x3F;
                res |= (byte & 0x1F) << shift;
                shift += 5;
                idx += 1
            } while (byte >= 0x20);
            
            let deltaLon = Double(((res % 2) == 1) ? ~(res >> 1) : res >> 1);
            longitude += deltaLon;
            
            let finalLat = latitude * 1E-5;
            let finalLon = longitude * 1E-5;
            
            let coord = CLLocationCoordinate2DMake(finalLat, finalLon)
            coords[coordIdx] = coord
            coordIdx += 1
            
            if (coordIdx == count) {
                count = count + 10;
            }
        }
        
        let poly = MKPolyline.init(coordinates: coords, count: coordIdx)
        return poly;
    }
    
    func polylinePointsString(_ encodedString:String) -> MyRouteObject? {
        let bytes = encodedString.utf8CString
        let length = encodedString.lengthOfBytes(using: .utf8)
        
        var idx = 0;
        
        var count = length / 4;
        
        let coords = NSMutableArray()
        
        var coordIdx = 0;
        
        var latitude = 0.0;
        var longitude = 0.0;
        
        while (idx < length) {
            var byte:Int
            var res:Int = 0
            var shift:Int = 0
            
            repeat {
                byte = bytes[idx].hashValue - 63;
                res |= (byte & 0x1F) << shift;
                shift += 5;
                
                idx += 1
            } while (byte >= 0x20);
            
            let deltaLat = Double(((res % 2) == 1) ? ~(res >> 1) : res >> 1);
            
            latitude += deltaLat;
            
            shift = 0;
            res = 0;
            
            repeat {
                byte = bytes[idx].hashValue - 0x3F;
                res |= (byte & 0x1F) << shift;
                shift += 5;
                idx += 1
            } while (byte >= 0x20);
            
            let deltaLon = Double(((res % 2) == 1) ? ~(res >> 1) : res >> 1);
            longitude += deltaLon;
            
            let finalLat = latitude * 1E-5;
            let finalLon = longitude * 1E-5;
            
            let coord = CLLocationCoordinate2DMake(finalLat, finalLon)
            coords.add(coord)
            coordIdx += 1
            
            if (coordIdx == count) {
                count = count + 10;
            }
        }
        
        let ob = MyRouteObject()
        ob.count1 = coordIdx;
        ob.coords = coords;
        
        return ob;
    }
    
    func polylinePointsMA(_ ma:NSMutableArray, _ count:Int) -> MKPolyline {
        
        let coords = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: count)

        var count1 = 0;
        
        for i in 0..<ma.count {
            let ob = ma[i] as? MyRouteObject
            
            for j in 0..<Int((ob?.count1)!) {
                if let obb = ob?.coords[j] as? CLLocationCoordinate2D {
                    
                    coords[count1] = obb
                    count1 += 1
                }
            }
        }
        
        let line = MKPolyline.init(coordinates: coords, count: count)
        
        free(coords);
        
        return line
    }
    
    public func polyline (_ l1:CLLocation, _ l2:CLLocation, _ key:String?, ai:Bool, popup:Bool, prnt:Bool, completion: @escaping (MKPolyline?) -> Swift.Void) {
        /*
         
         *************************************************************
         *************************************************************
         *************************************************************
         *************************************************************
         
                        HOW TO USE CODE FOR ROUTE IN MAP
         
                                DO NOT DELETE IT
         
         *************************************************************
         *************************************************************
         *************************************************************
         *************************************************************
         
        func routeBetweenTwoLocation () {
            Comman().polyline(l1, l2, googleApiKey, ai: true, popup: true, prnt: false) { (line) in
                
                if line != nil {
                    self.myPolyLinePath = line
                    
                    let overlays = self.map.overlays
                    self.map.removeOverlays(overlays)
                    self.map.add(self.myPolyLinePath)
                }
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let ann = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "currentloc")
            ann.canShowCallout = true;
            ann.animatesDrop = true;
            return ann;
        }
        
        var myPolyLinePath: MKPolyline!
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            if overlay is MKPolyline {
                let polyLineRender = MKPolylineRenderer(overlay: myPolyLinePath)
                polyLineRender.strokeColor = UIColor.red
                polyLineRender.lineWidth = 2.0
                
                return polyLineRender
            }
            
            return MKPolylineRenderer()
        }
        */
        
        var withKey = ""
        
        if key != nil {
            withKey = "&key=\(key!)"
        }
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(l1.coordinate.latitude),\(l1.coordinate.longitude)&destination=\(l2.coordinate.latitude),\(l2.coordinate.longitude)&sensor=false&mode=WALKING\(withKey)"
        
        Http.instance().json(url, nil, nil, ai: ai, popup: popup, prnt: prnt) { (json, param, resp) in
            var go = true
            
            if json != nil {
                let json = json as? NSDictionary
                
                let ma = NSMutableArray()
                
                if let routes = json!["routes"] as? NSArray {
                    for i in 0..<routes.count {
                        if let route = routes[i] as? NSDictionary {
                            if let arr = route["legs"] as? NSArray {
                                for j in 0..<arr.count {
                                    if let route1 = arr[j] as? NSDictionary {
                                        if let steps = route1["steps"] as? NSArray {
                                            
                                            var totalcount:Int = 0
                                            
                                            for k in 0..<steps.count {
                                                if let route2 = steps[k] as? NSDictionary {
                                                    
                                                    if let overviewPolyline = route2["polyline"] as? NSDictionary {
                                                        if let points = overviewPolyline["points"] as? String {
                                                            
                                                            let ob = self.polylinePointsString(points)
                                                            ma.add(ob);
                                                            
                                                            totalcount += Int((ob?.count1)!);
                                                            
                                                            if k+1 == steps.count {
                                                                let poly = self.polylinePointsMA(ma, totalcount)
                                                                go = false
                                                                completion(poly)
                                                            }
                                                        }
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            if go {
                completion(nil)
            }
        }
    }
}

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

public func isNull(value : AnyObject?) -> Bool {
    if value == nil {
        return true
    } else if value is NSNull {
        return true
    } else {
        return false
    }
}

public func callNumber(_ phoneNumber:String) {
    if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
        
        if (application.canOpenURL(phoneCallURL as URL)) {
            //application.openURL(phoneCallURL as URL);
            if #available(iOS 10.0, *) {
                application.open(phoneCallURL as URL, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                application.openURL(phoneCallURL as URL)
            }
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
