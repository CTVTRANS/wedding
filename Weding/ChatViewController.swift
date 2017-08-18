//
//  ChatViewController.swift
//  Weding
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.estimatedRowHeight = 140
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell: GusetViewCell = table.dequeueReusableCell(withIdentifier: "GuestViewCell", for: indexPath) as! GusetViewCell
            return cell
        }
        let cell: MyViewCell = table.dequeueReusableCell(withIdentifier: "MyViewCell", for: indexPath) as! MyViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

}
