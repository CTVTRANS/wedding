//
//  LoginTask.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class LoginTask: BaseTaskNetwork {
    
    override func path() -> String! {
        return "http://www.freewed.com.tw/api/GetMemberInfo.aspx?id=ann730204&k=1b7937b482b41432bf2168725ef78c212cb92360"
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        if let dictionary = response as? [String: Any] {
//            let account = dictionary["ACCOUNT"] as? String
//            let name = dictionary["NM"] as? String
//            let nickName = dictionary["NICKNM"] as? String
//            let mail = dictionary["MAIL"] as? String
            
            let manName = dictionary["ManNM"] as? String
            let manWeddingDay = dictionary["ENGDTD"] as? String
            let manWeddingCounter = dictionary["ENGDTDCounter"] as? String

            let womanName = dictionary["WomanNM"] as? String
            let womanWeddingDay = dictionary["COUPLEENGDTD"] as? String
            let womanWeddingCounter = dictionary["COUPLEENGDTDCounter"] as? String
            
            let woman: BrideModel = BrideModel.init(name: womanName!,
                                                    day: womanWeddingDay!,
                                                    dayCounter: womanWeddingCounter!)
            let man: GroomModel = GroomModel.init(name: manName!,
                                                  day: manWeddingDay!,
                                                  dayCounter: manWeddingCounter!)
            Constants.sharedInstance.woman = woman
            Constants.sharedInstance.man = man
        
        }
        return response
    }
    
}
