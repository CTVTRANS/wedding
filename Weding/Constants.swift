//
//  Constants.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

let mainUrl = "http://www.freewed.com.tw/api/GetGuestInfoByMember.aspx"
let login = "http://www.freewed.com.tw/api/GetMemberInfo.aspx"
let LINK_WEB = "http://www.freewed.com.tw/app/LOVE.aspx?ACCT=ann730204"
let LINK_WEB_LOGINED = "http://www.freewed.com.tw/app/index0.aspx?todo=logined#logined"
let LINK_DOWNLOAD_APP = "http://www.codingexplorer.com/"

class Constants: NSObject {
    
    var woman: BrideModel? = nil
    var man: GroomModel? = nil
    
    static let sharedInstance = Constants()
}
