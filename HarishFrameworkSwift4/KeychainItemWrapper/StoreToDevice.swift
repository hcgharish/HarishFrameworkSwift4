//
//  StoreToDevice.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 17/11/17.
//  Copyright © 2017 Harish. All rights reserved.
//

import UIKit

let KeyChainItemWrapper_Identifier = "KeyChainItemWrapper_Identifier"

public class StoreToDevice: NSObject {
    static let ob = KeychainPasswordItem(service: "password1", account: "password2")// = Keychai
    
    public func setDeviceStoredData (_ data:String) {
        do {
            try StoreToDevice.ob.savePassword(data)
        } catch {
            
        }
    }
    
    public func getStoredData () -> String? {
        do {
            return try StoreToDevice.ob.readPassword()
        } catch { }
        
        return nil
    }
}










