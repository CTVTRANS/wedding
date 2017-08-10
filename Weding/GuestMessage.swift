//
//  GuestMessage.swift
//  Weding
//
//  Created by Le Cong on 8/9/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class GuestMessage: NSObject {
    private var nameGuest: String?
    private var messageBoby: String?
    private var time: String?
    
    init(name: String, message: String, timeSend: String) {
        nameGuest = name
        messageBoby = message
        time = timeSend
    }
    
    func getname() -> String {
        return nameGuest!
    }
    
    func getMessge() -> String {
        return messageBoby!
    }
    
    func getTime() -> String {
        return time!
    }

}
