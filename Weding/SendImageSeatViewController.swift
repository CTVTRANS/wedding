//
//  SendImageSeatViewController.swift
//  Weding
//
//  Created by kien le van on 10/27/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class SendImageSeatViewController: BaseViewController {

    @IBOutlet weak var nameCompany: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var openWebButotn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        openWebButotn.layer.borderColor = UIColor.rgb(248, 54, 123).cgColor
        titleLabel.layer.borderColor = UIColor.rgb(248, 54, 123).cgColor
        nameCompany.text = Constants.sharedInstance.factory?.getName()
        navigationItem.title = "婚禮助手 App"
    }
    
    @IBAction func pressedButton(_ sender: Any) {
        sendImageOfPosition()
    }

}
