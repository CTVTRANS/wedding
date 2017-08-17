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
        let myAccount = Account.getAccount()
        let numberGest = myAccount.numberGuest
        let numberMessage = myAccount.numberMessage
        let numberSeat = myAccount.tableNotification
        if (index == 0 && numberGest > 0) {
            viewNotification.isHidden = false
            numberNotification.text = String(numberGest)
        } else if (index == 3 && numberMessage > 0){
            viewNotification.isHidden = false
            numberNotification.text = String(numberMessage)
        } else if (index == 4 && numberSeat > 0) {
            viewNotification.isHidden = false
            numberNotification.text = String(numberSeat)
        }
        nameRow.text = name
    }
}
