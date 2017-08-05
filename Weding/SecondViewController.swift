//
//  SecondViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var replyMessageView: UIView!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "navigationBar"), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
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
