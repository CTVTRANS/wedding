//
//  UpdateNumberNotice.swift
//  Weding
//
//  Created by le kien on 12/26/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class UpdateNumberNotice: BaseTaskNetwork {

    var type = 1
    
    init(type: Int) {
        self.type = type
    }
    
    override func path() -> String! {
        return updateNotice + "id=\(Account.getAccount().name)&k=\(Account.getAccount().keyAccess)&t=\(type)"
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        return response
    }
}
