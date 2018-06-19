//
//  GenricViewController.swift
//  VegiDelivery
//
//  Created by Avinash somani on 13/10/16.
//  Copyright © 2016 Kavyasoftech. All rights reserved.
//

import UIKit

class BaseUrl: NSObject {
    var baseUrl = ""
}

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

let rs_sign = "\u{20B9}"

let base_url = "http://192.168.11.153/StayConnected/API/api/baseURL"
//let base_url = "http://devstayconnected.kavyasoftech.com/API/api/baseURL"


class AlertMSG: NSObject {
    static let blankEmail = "Please enter your email."
    static let blankEmailOrNumber = "Please enter your email or contact number."
    static let invalidEmail = "Please enter valid email."
    static let invalidEmailOrNumber = "Please enter valid email or contact number."
    static let blankPassword = "Please enter password."
    static let passwordLength = "Password should be between 4-20 characters."
    static let blankCnfPwd = "Please enter confirm password."
    static let pwdMismatch = "Password and confirm password does not match."
    static let acceptTerms = "Please accept the terms and conditions."
    static let blankFirstname = "Please enter your first name."
    static let invalidFirstName = "Please enter valid First name."
    static let blankLastName = "Please enter your last name."
    static let invalidLastName = "Please enter valid Last name."
    static let blankMobile = "Please enter mobile number."
    static let invalidMobile = "Mobile number is not valid."
    static let verificationCode = "Please enter verification code."
    static let mobileAlreadyRegistered = "This mobile number is already registered with us."
    static let blankOTP = "Please enter OTP"
    static let invalidOTP = "Please enter valid OTP."
    static let blankTitle = "Please enter title."
    static let blankQuery = "Please enter your query."
    static let blankProductName = "Please enter product name."
    static let blankProductDescription = "Please enter product description and quantity."
    static let currentpassword = "Please enter current password."
    
    static let blankCompanyName = "Please enter company name."
    static let blankPrimaryAddress = "Please enter primary address."
    static let blankSecondaryAddress = "Please enter secondary address"
    static let blankPostCode = "Please enter postal code."
    static let blankCity = "please enter city."
    static let selectCountry = "please select country."
    static let selectState = "Please select state/region."
    static let blankphonenumber = "Please enter phone number."
    static let validphonenumber = "Please enter valid Phone number."
    static let blanknewpassword = "Please enter new password."
    static let blankreenterpassword = "Please confirm the password."
    static let passwordMismatch = "You re-entered wrong password."
}

class Base: NSObject {
    
}

func dayshours (_ days:String, _ hours:String) -> String {
    var day:Int = 0
    
    if days.characters.count > 0 {
        day = Int(days)!
    }
    
    var hour:Int = 0
    
    if hours.characters.count > 0 {
        hour = Int(hours)!
    }
    
    if day > 1 {
        if hour > 1 {
            return "\(day) days \(hour) hours"
        } else {
            return "\(day) days \(hour) hour"
        }
    } else {
        if hour > 1 {
            return "\(day) day \(hour) hours"
        } else {
            return "\(day) day \(hour) hour"
        }
    }
}









