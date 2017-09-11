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
    @IBOutlet weak var hightOffAvatar: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = hightOffAvatar.constant / 2
    }

    func binData(guest: GuestMessage) {
        nameGuest.text = guest.getname()
        let date = guest.getTime().components(separatedBy: " ")
        time.text = date[0]
        message.text = guest.getMessge()
        avatar.image = guest.getImage()
    }
}
