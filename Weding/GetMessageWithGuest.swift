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
    private var _idGuest: String!
    
    init(idGuest: String, page: Int, limit: Int) {
        _idGuest = idGuest
        _page = page
        _limit = limit
    }
    
    override func path() -> String! {
        return getMessageGuest + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess
            + "&guest_id=" + _idGuest
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func parameters() -> [AnyHashable: Any]! {
        return ["pno": _page, "pnum": _limit]
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
        var isMyMessage = false
        var status = false
        let fromUser = dictionary["FROM_USER_ACCOUNT"] as? String ?? ""
        if fromUser == Account.getAccount().name {
            isMyMessage = true
        }
        let content = dictionary["MESSAGE_CONTENT"] as? String ?? ""
        let time = dictionary["MESSAGE_TIME"] as? String ?? ""
        let isReaed = dictionary["IS_PUSH"] as? Int ?? 0
        if isReaed == 1 {
            status = true
        }
        let message = Message(myMessage: isMyMessage, message: content, timeSend: time, isReaded: status)
        return message
    }
}
