//
//  Constants.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

let loginKey = "free123"
let login = "http://www.freewed.com.tw/api/GetMemberInfo.aspx"
let linkWeb = "http://www.freewed.com.tw/app/LOVE.aspx?ACCT=ann730204"
let linkWebLogin = "http://www.freewed.com.tw/app/index0.aspx?todo=logined#logined"
let linkDownloadApp = "http://www.codingexplorer.com/"
let memberList = "http://gps.transoftvietnam.com/member_list.xlsx"

class Constants {
    var woman: BrideModel?
    var man: GroomModel?
    var factory: Factory?
    
    static let sharedInstance = Constants()
}
