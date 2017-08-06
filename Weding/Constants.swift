//
//  Constants.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

let mainUrl = "http://www.freewed.com.tw/api/GetGuestInfoByMember.aspx"

class Constants: NSObject {
    
    var woman: BrideModel? = nil
    var man: GroomModel? = nil
    
    static let sharedInstance = Constants()
}
