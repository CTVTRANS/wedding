//
//  MyViewCell.swift
//  Weding
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class MyViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var widthOfTime: NSLayoutConstraint!
    
    @IBOutlet weak var widthOfMessage: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func binData(myMessage: Message) {
        message.text = myMessage.getMessage()
        let timeDate = myMessage.getTime().components(separatedBy: "T")[0]
        let month: Int = Int((timeDate.components(separatedBy: "-")[1]))!
        let date: Int = Int((timeDate.components(separatedBy: "-")[2]))!
        let timeString: String = String(month) + "/" + String(date)
        
        let timeHour = myMessage.getTime().components(separatedBy: "T")[1]
        let hour = timeHour.components(separatedBy: ":")[0]
        let min = timeHour.components(separatedBy: ":")[1]
        
        self.time.text = timeString + " " + hour + ":" + min
    }

}
