//
//  MessageViewCell.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {

    @IBOutlet weak var numberMessage: UILabel!
    @IBOutlet weak var numberMessageView: UIView!
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
        let getNewestMessage = GetMessageWithGuest(idGuest: guest.idGuest, page: 1, limit: 9)
        getNewestMessage.request(blockSucess: { (data) in
            var numberNewMessage = 0
            guard let arr = data as? [Message], arr.count > 0 else {
                return
            }
            for message in arr where !message.isMyMessage() && !message.isReades() {
                numberNewMessage += 1
            }
            let newest = arr.first
            self.message.text = newest?.getMessage()
            if let date = Date.convertToDateWith(timeInt: (newest?.getTime())!, withFormat: "yyyy-MM-dd'T'HH-mm-ss") {
                let time = Date.convert(date: date, toString: "MM/dd HH:mm")
                self.time.text = time
            }
            self.numberMessage.isHidden = false
            self.numberMessage.text = numberNewMessage.description
            if numberNewMessage > 0 {
                self.numberMessageView.isHidden = false
            } else {
                self.numberMessageView.isHidden = true
            }
        }) { (_) in

        }
    }
}
