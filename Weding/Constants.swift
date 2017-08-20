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
let linkWebLogin = "http://www.freewed.com.tw/app/index0.aspx?todo=logined#logined"
let sendMessage = "http://www.freewed.com.tw/api/UpdateData.aspx?"

class Constants {
    var woman: Woman?
    var man: Man?
    var factory: Factory?
    var keyAccount: String?
    var currentNotificationGuest: Int?
    var currentNotificationMessage: Int?
    var currentNotificationSeat: Int?
    
    static let sharedInstance = Constants()
}
