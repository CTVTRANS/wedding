//
//  Constants.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

let baseURL = "http://www.freewed.com.tw/"
let loginKey = "free123"
let login =  baseURL + "api/GetMemberInfo.aspx"
let linkWebLogin = baseURL + "app/index0.aspx?"
let sendData = baseURL + "api/UpdateData.aspx?"
let downloadExcel = baseURL + "api/GetGuestPlanDoc.aspx?"
let getListGuestURL = baseURL + "/api/GetGuestInfoByMember.aspx?"
let getMessageGuest = baseURL + "/api/GetMemberGuestHistoryMessage.aspx?"
let linkguideExcel = baseURL + "/app/guest_doc_guide.aspx"
let getNumberNotice = baseURL + "/api/GetMemberMessageCounts.aspx?"
let updateNotice = baseURL + "/api/UpdateMemberMessageCountsStatus.aspx?"
let updateStatusMessage = baseURL + "/api/UpdateMemberGuestMessageStatus.aspx?"

let widthScreen = UIScreen.main.bounds.width
let heightScreen = UIScreen.main.bounds.height

class Constants {
    var woman: Woman?
    var man: Man?
    var factory: Factory?
    var token: String?
    var keyAccount: String?
    
    var newGuest: Int = 0
    var newMessage: Int = 0
    var newSeat: Int = 0
    
    static let shared = Constants()
}
