//
//  ConfirmReadedMessageTask.swift
//  Weding
//
//  Created by le kien on 12/8/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class ConfirmReadedMessageTask: BaseTaskNetwork {

    let idGuest: String!
    
    init(idGuest: String) {
        self.idGuest = idGuest
    }
    
    override func path() -> String! {
        return readedMessageURL + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess + "&guest_id=\(idGuest!)"
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        return response
    }
}
