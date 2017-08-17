//
//  Account.swift
//  Weding
//
//  Created by kien le van on 8/17/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class Account: NSObject, NSCoding {
    private var accountName: String!
    private var linkMember: String!
    private var totalGuest: Int!
    private var totalMessage: Int!
    private var tableSeat: Int!
    
    init(name: String, numberGuest: Int, numberMessage: Int, memberURL: String, seat: Int) {
        accountName = name
        totalGuest = numberGuest
        totalMessage = numberMessage
        linkMember = memberURL
        tableSeat = seat
    }
    
    required init(coder decoder: NSCoder) {
        accountName = decoder.decodeObject(forKey: "accountName") as! String
        linkMember = decoder.decodeObject(forKey: "linkMember") as! String
        totalGuest = decoder.decodeObject(forKey: "totalGuest") as! Int
        totalMessage = decoder.decodeObject(forKey: "totalMessage") as! Int
        tableSeat = decoder.decodeObject(forKey: "tableSeat") as! Int
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(accountName, forKey: "accountName")
        coder.encode(linkMember, forKey: "linkMember")
        coder.encode(totalGuest, forKey: "totalGuest")
        coder.encode(totalMessage, forKey: "totalMessage")
        coder.encode(tableSeat, forKey: "tableSeat")
    }
    
    class func saveAccount(myAccount: Account) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: myAccount)
        UserDefaults.standard.set(encodedData, forKey: "myAccount")
    }
    
    class func getAccount() -> Account {
        if let data = UserDefaults.standard.data(forKey: "myAccount"),
            let myAccount = NSKeyedUnarchiver.unarchiveObject(with: data) as? Account {
            return myAccount
        } else {
            let myAccount: Account? = nil
            return myAccount!
        }
    }
    
    var name: String {
        get {
            return accountName
        }
        set {
            accountName = newValue
        }
    }
    var numberGuest: Int {
        get {
            return totalGuest
        }
        set {
            totalGuest = newValue
        }
    }
    var numberMessage: Int {
        get {
            return totalMessage
        }
        set {
            totalMessage = newValue
        }
    }
    var memberURL: String {
        get {
            return linkMember
        }
        set {
            linkMember = newValue
        }
    }
    var tableNotification: Int {
        get {
            return tableSeat
        }
        set {
            tableSeat = newValue
        }
    }

}
