//
//  DowloadExcel.swift
//  Weding
//
//  Created by Le Cong on 8/8/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class DowloadMemberList: BaseTaskNetwork {
    
    private var urlExcel:String
    
    init(linkUrl: String) {
        self.urlExcel = linkUrl
    }
    
    override func path() -> String! {
//        return memberList
        return urlExcel
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        
        return response
    }
    
}
