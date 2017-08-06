//
//  SecondViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navigation: SecondNavigation!
    @IBOutlet weak var replyMessageView: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var manName: UILabel!
    @IBOutlet weak var womanName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            navigation.leftButton.addTarget(self.revealViewController(), action: #selector(revealViewController().revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        manName.text = Constants.sharedInstance.man?.getNameGroom()
        womanName.text = Constants.sharedInstance.woman?.getNameBride()
        
        replyMessageView.layer.borderColor = UIColor.init(red: 236/255.0, green: 186/255.0, blue: 206/255.0, alpha: 1.0).cgColor
        table.layer.borderColor = UIColor.init(red: 236/255.0, green: 186/255.0, blue: 206/255.0, alpha: 1.0).cgColor
        table.layer.borderWidth = 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MessageViewCell = table.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageViewCell
        cell.binData()
        return cell
    }

}
