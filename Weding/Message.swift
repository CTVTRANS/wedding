//
//  GuestMessage.swift
//  Weding
//
//  Created by Le Cong on 8/9/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class Message: NSObject {
    private var _isMyMessage: Bool!
    private var messageBoby: String!
    private var time: String!
    private var _isReaded: Bool!
    
    override init() {
        super.init()
    }
    
    init(myMessage: Bool, message: String, timeSend: String, isReaded: Bool) {
        _isMyMessage = myMessage
        messageBoby = message
        time = timeSend
        _isReaded = isReaded
    }
    
    func isMyMessage() -> Bool {
        return _isMyMessage
    }
    
    func getMessage() -> String {
        return messageBoby
    }
    
    func isReades() -> Bool {
        return _isReaded
    }
    
    func getTime() -> String {
        return time
    }
}

enum MessageOwner: Int {
    case myMessage = 0, guestMessage = 1
}
