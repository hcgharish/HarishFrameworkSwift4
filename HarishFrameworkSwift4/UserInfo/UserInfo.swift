//
//  UserInfo.swift
//  Zooma
//
//  Created by Avinash somani on 26/12/16.
//  Copyright © 2016 Kavyasoftech. All rights reserved.
//

import UIKit

open class UserInfo: NSObject, NSCoding {
    var date = ""
    var email = ""
    var first_name = ""
    var id = ""
    var image = ""
    var last_name = ""
    var password = ""
    var status = ""
    var time = ""
    var allowed_time = ""
    var amout = ""
    var category_id = ""
    var category_name = ""
    var event_date = ""
    var event_duration = ""
    var event_status = ""
    var name = ""
    var start_time = ""
    var paypal_id = ""
    var referral_code = ""

    override public init() {
        
    }
    
    public init(_ date:String, _ email:String, _ first_name:String, _ id:String, _ image:String, _ last_name:String, _ password:String, _ status:String, _ time:String, _ allowed_time:String, _ amout:String, _ category_id:String, _ category_name:String, _ event_date:String, _ event_duration:String, _ event_status:String, _ name:String, _ start_time:String, _ paypal_id:String, referral_code: String) {
        self.date = date
        self.email = email
        self.first_name = first_name
        self.id = id
        self.image = image
        self.last_name = last_name
        self.password = password
        self.status = status
        self.time = time
        self.allowed_time = allowed_time
        self.amout = amout
        self.category_id = category_id
        self.category_name = category_name
        self.event_date = event_date
        self.event_duration = event_duration
        self.event_status = event_status
        self.name = name
        self.start_time = start_time
        self.paypal_id = paypal_id
        self.referral_code = referral_code
    }
    
    open func encode(with aCoder: NSCoder) {
        /*aCoder.encode(date, forKey: "date")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(first_name, forKey: "first_name")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(last_name, forKey: "last_name")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(allowed_time, forKey: "allowed_time")
        aCoder.encode(amout, forKey: "amout")
        aCoder.encode(category_name, forKey: "category_name")
        aCoder.encode(event_date, forKey: "event_date")
        aCoder.encode(event_duration, forKey: "event_duration")
        aCoder.encode(event_status, forKey: "event_status")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(start_time, forKey: "start_time")

        aCoder.encode(paypal_id, forKey: "paypal_id")
        aCoder.encode(referral_code, forKey: "referral_code")
        */
    }
    
    public required init?(coder aDecoder: NSCoder) {
        /*date = aDecoder.decodeObject(forKey: "date") as! String!
        email = aDecoder.decodeObject(forKey: "email") as! String!
        first_name = aDecoder.decodeObject(forKey: "first_name") as! String!
        id = aDecoder.decodeObject(forKey: "id") as! String!
        last_name = aDecoder.decodeObject(forKey: "last_name") as! String!
        status = aDecoder.decodeObject(forKey: "status") as! String!
        image = aDecoder.decodeObject(forKey: "image") as! String!
        password = aDecoder.decodeObject(forKey: "password") as! String!
        time = aDecoder.decodeObject(forKey: "time") as! String!
        allowed_time = aDecoder.decodeObject(forKey: "allowed_time") as! String!
        amout = aDecoder.decodeObject(forKey: "amout") as! String!
        category_name = aDecoder.decodeObject(forKey: "category_name") as! String!
        event_date = aDecoder.decodeObject(forKey: "event_date") as! String!
        event_duration = aDecoder.decodeObject(forKey: "event_duration") as! String!
        event_status = aDecoder.decodeObject(forKey: "event_status") as! String!
        name = aDecoder.decodeObject(forKey: "name") as! String!
        start_time = aDecoder.decodeObject(forKey: "start_time") as! String!

        paypal_id = aDecoder.decodeObject(forKey: "paypal_id") as! String!
        referral_code = aDecoder.decodeObject(forKey: "referral_code") as! String!
        */
    }
    
    class public func archivePeople(_ people:UserInfo) -> NSData {
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: people)
        return archivedObject as NSData
    }
    
    class public func retrievePeople(_ data:NSData) -> UserInfo {
        return (NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? UserInfo)!
    }
    
    class public func save (_ ob:UserInfo) {
        let defaults = UserDefaults.standard
        defaults.set(archivePeople(ob), forKey: "LoginInfo")
        defaults.synchronize()
    }
    
    public func save () {
        UserInfo.save(self)
    }
    
    public class func logout () {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "LoginInfo")
        defaults.synchronize()
    }

    open class func user1() -> Any? {
        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: "LoginInfo") != nil) {
            let data = defaults.object(forKey: "LoginInfo") as! NSData
            return retrievePeople(data)
        } else {
            return nil
        }
    }
    
    open func user() ->  Any? {
        return UserInfo.user1()
    }
}







