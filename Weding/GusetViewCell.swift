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
    @IBOutlet weak var hightOfAvatar: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = hightOfAvatar.constant / 2
    }
    
    func binData(guestMessage: Message) {
        message.text = guestMessage.getMessage()
        let date = Date.convertToDateWith(timeInt: guestMessage.getTime(), withFormat: "yyyy-MM-dd'T'HH-mm-ss")
        let time = Date.convert(date: date!, toString: "MM/dd HH:mm")
        self.timeMessage.text = time
    }
}
