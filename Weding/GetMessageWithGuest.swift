//
//  GetMessageWithGuest.swift
//  Weding
//
//  Created by Kien on 10/30/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class GetMessageWithGuest: BaseTaskNetwork {
    
    private var _limit: Int!
    private var _page: Int!
    
    init(page: Int, limit: Int) {
        _page = page
        _limit = limit
    }
    
    override func path() -> String! {
        return getMessageGuest + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func parameters() -> [AnyHashable: Any]! {
        return ["page": _page, "limit": _limit]
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listMessage: [Message] = []
        if let arrayMessage = response as? [[String: Any]] {
            for dictionary in arrayMessage {
                let message = parseMessage(dictionary: dictionary)
                listMessage.append(message)
            }
        }
        return listMessage
    }
}

extension BaseTaskNetwork {
    func parseMessage(dictionary: [String: Any]) -> Message {
        let messageOwner = dictionary[""] as? Int ?? 0
        let content = dictionary[""] as? String ?? ""
        let time = dictionary[""] as? String ?? ""
        let message = Message(messageOwner: messageOwner, message: content, timeSend: time)
        return message
    }
}
