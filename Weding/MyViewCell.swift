//
//  MyViewCell.swift
//  Weding
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class MyViewCell: UITableViewCell {

    @IBOutlet weak var test: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var widthOfMessage: NSLayoutConstraint!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        test.tintColor = UIColor.green
    }

    func binData(myMessage: Message) {
        message.text = myMessage.getMessage()
        let date = Date.convertToDateWith(timeInt: myMessage.getTime(), withFormat: "yyyy-MM-dd'T'HH-mm-ss")
        let time = Date.convert(date: date!, toString: "MM/dd HH:mm")
        self.time.text = time
    }

}

extension Date {
    static func convertToDateWith(timeInt: String, withFormat: String) -> Date? {
        let dateFomater = DateFormatter()
        dateFomater.dateFormat = withFormat
        let date = dateFomater.date(from: timeInt)
        return date
    }
    
    static func convert(date: Date, toString timeOut: String) -> String {
        let dateFomater = DateFormatter()
        dateFomater.dateFormat = timeOut
        let dateString = dateFomater.string(from: date)
        return dateString
    }
}
