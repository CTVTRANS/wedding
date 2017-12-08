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
        let timeDate = guestMessage.getTime().components(separatedBy: "T")[0]
        let month: Int = Int((timeDate.components(separatedBy: "-")[1]))!
        let date: Int = Int((timeDate.components(separatedBy: "-")[2]))!
        let timeString: String = String(month) + "/" + String(date)
        
        let timeHour = guestMessage.getTime().components(separatedBy: "T")[1]
        let hour = timeHour.components(separatedBy: ":")[0]
        let min = timeHour.components(separatedBy: ":")[1]
        self.timeMessage.text = timeString + " " + hour + ":" + min
    }

}
