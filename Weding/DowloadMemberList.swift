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
    
    private var _object: String
    
    init(object: String) {
        _object = object
    }
    
    override func path() -> String! {
        return downloadExcel + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess + "&g=" + _object
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        
        return response
    }
    
}
