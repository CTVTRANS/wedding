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
        let getNewestMessage = GetMessageWithGuest(idGuest: guest.idGuest, page: 1, limit: 1)
        getNewestMessage.request(blockSucess: { (data) in
            if let arr = data as? [Message] {
                if arr.first != nil {
                    let newest = arr[0]
                    self.message.text = newest.getMessage()
                    let timeDate = newest.getTime().components(separatedBy: "T")[0]
                    let month: Int = Int((timeDate.components(separatedBy: "-")[1]))!
                    let date: Int = Int((timeDate.components(separatedBy: "-")[2]))!
                    let timeString: String = String(month) + "/" + String(date)
                    self.time.text = timeString
                    
                    if newest.isReades() {
                        self.numberMessage.isHidden = true
                    }
                }
            }
        }) { (_) in
            
        }
    }
}
