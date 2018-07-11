//
//  Map.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/07/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit
import MapKit

open class Poly: NSObject {
    var coords:NSMutableArray!
    var count1:Int = 0;
    
    override init() {
        super.init()
    }
}

open class Map: NSObject {
    open class func instance () -> Map {
        return Map()
    }
    
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
    
    func polylinePointsString(_ encodedString:String) -> Poly? {
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
        
        let ob = Poly()
        ob.count1 = coordIdx;
        ob.coords = coords;
        
        return ob;
    }
    
    func polylinePointsMA(_ ma:NSMutableArray, _ count:Int) -> MKPolyline {
        
        let coords = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: count)
        
        var count1 = 0;
        
        var bool = true
        
        for i in 0..<ma.count {
            let ob = ma[i] as? Poly
            
            for j in 0..<Int((ob?.count1)!) {
                if let obb = ob?.coords[j] as? CLLocationCoordinate2D {
                    if bool {
                        coords[count1] = obb
                        count1 += 1
                    }
                    
                    if count > 10000 {
                        bool = !bool
                    }
                }
            }
        }
        
        let line = MKPolyline.init(coordinates: coords, count: count1)
        
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
            Map.instance().polyline(l1, l2, googleApiKey, ai: true, popup: true, prnt: false) { (line) in
         
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
                                                            ma.add(ob!);
                                                            
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







