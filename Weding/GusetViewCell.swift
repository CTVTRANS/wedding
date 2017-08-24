//
//  GusetViewCell.swift
//  Weding
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class GusetViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var timeMessage: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    func binData(guestMessage: GuestMessage) {
        message.text = guestMessage.getMessge()
        timeMessage.text = guestMessage.getTime()
        avatar.image = guestMessage.getImage()
    }

}
