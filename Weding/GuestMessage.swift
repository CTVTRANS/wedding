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
    private var image: UIImage?
    
    init(name: String, message: String, timeSend: String, avatar: UIImage) {
        nameGuest = name
        messageBoby = message
        time = timeSend
        image = avatar
    }
    
    func getImage() -> UIImage {
        return image!
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
