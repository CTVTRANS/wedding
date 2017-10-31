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
        time.text = myMessage.getTime()
    }

}
