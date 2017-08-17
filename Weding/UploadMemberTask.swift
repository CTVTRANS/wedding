//
//  UploadMemberTask.swift
//  Weding
//
//  Created by kien le van on 8/15/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class UploadMemberTask: BaseTaskNetwork {
    
    private var filePath: URL?
    
    init(fileUrl: URL) {
        self.filePath = fileUrl
    }
    
    override func fileURL() -> URL! {
        return self.filePath
    }
    
    override func path() -> String! {
        return "http://www.freewed.com.tw/api/UpdateData.aspx?id=ann730204&k=1b7937b482b41432bf2168725ef78c212cb92360"
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["todo": "MemberAddGuestPlanDoc2"]
    }
    
    override func method() -> String! {
        return POST
    }
    
    override func data(withResponse response: Any!) -> Any! {
        if let dictionary = response as? [String: Any] {
            let mesage:String = (dictionary["ErrMsg"] as? String)!
            return mesage
        }
        return nil
    }
}
