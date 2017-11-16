//
//  SendToken.swift
//  Weding
//
//  Created by kien le van on 8/24/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class SendToken: BaseTaskNetwork {
    
    override func parameters() -> [AnyHashable: Any]! {
        return ["token": Account.getAccount().token]
    }
    
    override func path() -> String! {
        return login + "?id=" + Account.getAccount().name + "&k=" + Constants.shared.keyAccount!
    }
    
    override func method() -> String! {
        return POST
    }
    
    override func data(withResponse response: Any!) -> Any! {
        return response
    }
}
