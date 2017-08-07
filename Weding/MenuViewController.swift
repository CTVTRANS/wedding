//
//  MenuViewController.swift
//  Weding
//
//  Created by kien le van on 8/5/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import SWRevealViewController

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SWRevealViewControllerDelegate {

    @IBOutlet weak var table: UITableView!
    var arrayRow = ["row1", "row2", "row3", "row4", "row5", "row6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.revealViewController().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuViewCell = table.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuViewCell
        cell.binData(name: arrayRow[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        switch row {
            case 0:
                print("0")
            case 1:
                print("1")
            case 2:
                print("2")
            case 3:
                print("3")
            case 4:
                print("4")
            default:
                print("5")

        }
    }
    
//    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
//        let currentNavicontroller = self.revealViewController().frontViewController as! UINavigationController
//        if (currentNavicontroller.topViewController is SecondViewController) {
//            arrayRow = ["row1", "row2", "row3", "row4"]
//            table.reloadData()
//        }
//       
//    }

}
