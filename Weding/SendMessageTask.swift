//
//  SendMessageTask.swift
//  Weding
//
//  Created by kien le van on 8/19/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class SendMessageTask: BaseTaskNetwork {
    
    let guestName: String!
    let content: String!
    
    init(name: String, contentMessage: String) {
        self.guestName = name
        self.content = contentMessage
    }
    
    override func path() -> String! {
        return sendData + "id=" + Account.getAccount().name + "&k=" + Constants.sharedInstance.keyAccount!
    }

    override func method() -> String! {
        return POST
    }
    
    override func parameters() -> [AnyHashable : Any]! {
        return ["todo": "MemberAddMessageToGuest", "GuestList": guestName, "msg": content]
    }
    
    override func data(withResponse response: Any!) -> Any! {
        if let dictionary = response as? [String: Any] {
            let name = dictionary["ErrMsg"] as? String
            return name
        }
        return nil
    }
}
