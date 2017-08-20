//
//  MenuViewCell.swift
//  Weding
//
//  Created by kien le van on 8/5/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {

    @IBOutlet weak var nameRow: UILabel!
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var numberNotification: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewNotification.isHidden = true
    }
    
    func binData(name: String, index: Int) {
        let numberGest: Int = Constants.sharedInstance.currentNotificationGuest!
        let numberMessage: Int = Constants.sharedInstance.currentNotificationMessage!
        let numberSeat: Int = Constants.sharedInstance.currentNotificationSeat!
        nameRow.text = name
        if (index == 0 && numberGest > 0 && numberGest <= 9) {
            viewNotification.isHidden = false
            numberNotification.text = String(numberMessage)
        } else if (index == 0 && numberGest > 9){
            viewNotification.isHidden = false
            numberNotification.text = "9"
        } else if (index == 3 && numberMessage > 0 && numberMessage <= 9) {
            viewNotification.isHidden = false
            numberNotification.text = String(numberMessage)
        } else if (index == 3 && numberMessage > 9) {
            viewNotification.isHidden = false
            numberNotification.text = "9"
        } else if (index == 4 && numberSeat > 0) {
            viewNotification.isHidden = false
            numberNotification.text = String(numberSeat)
        } else {
            viewNotification.isHidden = true
        }
    }
}
