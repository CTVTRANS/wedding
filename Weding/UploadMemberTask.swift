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
    
    private var fiklPathUrl:URL
    
    init(fileUrl: URL) {
        self.fiklPathUrl = fileUrl
    }
    
    override func fileURL() -> URL! {
        return fiklPathUrl
    }
    
    override func path() -> String! {
        return memberList
        //        return upLinkUrl
    }
    
    override func method() -> String! {
        return POST
    }
    
    override func data(withResponse response: Any!) -> Any! {
        
        return response
    }
}
