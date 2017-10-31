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

    func binData(guest: Guest) {
        nameGuest.text = guest.nameGuest
        avatar.sd_setImage(with: URL(string: guest.avatar))
        let getNewestMessage = GetMessageWithGuest(page: 1, limit: 1)
        getNewestMessage.request(blockSucess: { (data) in
            if let newestMessage = data as? [Message] {
                self.message.text = newestMessage.first?.getMessage()
                self.time.text = newestMessage.first?.getTime().components(separatedBy: " ")[1]
            }
        }) { (_) in
            
        }
    }
}
