//
//  UpdateStatusMessage.swift
//  Weding
//
//  Created by le kien on 12/28/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import Foundation
import LCNetwork

class UpdateStatusMessage: BaseTaskNetwork {
    
    var guestID = ""
    
    init(guestID: String) {
        self.guestID = guestID
    }
    
    override func path() -> String! {
        return updateStatusMessage + "id=\(Account.getAccount().name)&k=\(Account.getAccount().keyAccess)&guest_id=\(guestID)"
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        return response
    }
}
