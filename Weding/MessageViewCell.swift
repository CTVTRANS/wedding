//
//  MessageViewCell.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {

    @IBOutlet weak var nameGuest: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func binData(guest: GuestMessage) {
        nameGuest.text = guest.getname()
        time.text = guest.getTime()
        message.text = guest.getMessge()
        avatar.image = guest.getImage()
    }
}
