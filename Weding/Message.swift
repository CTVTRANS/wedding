//
//  GuestMessage.swift
//  Weding
//
//  Created by Le Cong on 8/9/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class Message: NSObject {
    private var messageOwner: Int!
    private var messageBoby: String!
    private var time: String!
    
    init(messageOwner: Int, message: String, timeSend: String) {
        self.messageOwner = messageOwner
        messageBoby = message
        time = timeSend
    }
    
    func getOwner() -> Int {
        return messageOwner
    }
    
    func getMessage() -> String {
        return messageBoby
    }
    
    func getTime() -> String {
        return time
    }
}

enum MessageOwner: Int {
    case myMessage = 0, guestMessage = 1
}
