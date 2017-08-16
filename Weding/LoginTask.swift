//
//  LoginTask.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork
import CryptoSwift

class LoginTask: BaseTaskNetwork {
    let useName: String!
    let passWord: String!
    
    init(name: String, pass: String) {
        useName = name
        passWord = pass
    }
    
    func getKey() -> String {
        let key = "username=" + useName + "&password=" + passWord + "&key=" + loginKey
        let keySHA1 = key.sha1()
        return keySHA1
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["id": useName, "k": getKey()]
    }
    
    override func path() -> String! {
        return login
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        if let dictionary = response as? [String: Any] {
            let manName = dictionary["ManNM"] as? String
            let manWeddingDay = dictionary["ENGDTD"] as? String
            let manWeddingCounter = dictionary["ENGDTDCounter"] as? String
            let manNumberCustomer = dictionary["VIPLETTERCOUNT1"] as? Int
            let manLLinkExcel = dictionary["MEMBER_DOC_GUESTPLA N_URL"] as? String ?? "abc"
            
            let womanName = dictionary["WomanNM"] as? String
            let womanWeddingDay = dictionary["COUPLEENGDTD"] as? String
            let womanWeddingCounter = dictionary["COUPLEENGDTDCounter"] as? String
            let womanNumberCustomer = dictionary["VIPLETTERCOUNT2"] as? Int
            let womanLinkExcel = dictionary["MEMBER_DOC_GUESTPLA N2_URL"] as? String ?? "abc"
            
            let woman: Woman = Woman.init(name: womanName!,
                                          day: womanWeddingDay!,
                                          dayCounter: womanWeddingCounter!,
                                          numberGuest:  manNumberCustomer!,
                                          linkdownloadExcel: womanLinkExcel)
            let man: Man = Man.init(name: manName!,
                                    day: manWeddingDay!,
                                    dayCounter: manWeddingCounter!,
                                    numberCustomer: womanNumberCustomer!,
                                    linkDownloadExcel: manLLinkExcel)
            Constants.sharedInstance.woman = woman
            Constants.sharedInstance.man = man
        }
        return response
    }
}
