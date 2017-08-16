//
//  MenuViewController.swift
//  Weding
//
//  Created by kien le van on 8/5/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import SWRevealViewController

class MenuViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, SWRevealViewControllerDelegate {

    @IBOutlet weak var table: UITableView!
    var arrayRow = ["檢視邀約平台", "分享邀約平台", "賓客規劃表", "發送即時訊息", "婚禮管家", "桌位圖表發佈賓客", "回首頁"]
    var swVC:SWRevealViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        self.revealViewController().delegate = self
        swVC = self.revealViewController()
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
        table.deselectRow(at: indexPath, animated: false)
        switch row {
        case 0:
            UIApplication.shared.openURL(URL(string: linkWeb)!)
        case 1:
            swVC.revealToggle(animated: true)
            shareApp()
        case 2:
            let vc: ExcelController = self.storyboard?.instantiateViewController(withIdentifier: "ExcelController") as! ExcelController
            let navigationVC: UINavigationController = swVC.frontViewController as! UINavigationController
            if (navigationVC.topViewController is ExcelController) {
                swVC.revealToggle(animated: true)
                return
            }
            navigationVC.pushViewController(vc, animated: false)
            swVC.pushFrontViewController(navigationVC, animated: true)
        case 3:
            showSecondView()
        case 4:
            UIApplication.shared.openURL(URL(string: linkWebLogin)!)
            swVC.revealToggle(animated: true)
            sendImageOfPosition()
        default:
            let vc: MainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as! MainViewController
            let navigationVC: UINavigationController = swVC.frontViewController as! UINavigationController
            if (navigationVC.topViewController is MainViewController) {
                swVC.revealToggle(animated: true)
                return
            }
            navigationVC.pushViewController(vc, animated: false)
            swVC.pushFrontViewController(navigationVC, animated: true)
        }
    }
    
    func showSecondView() {
        let vc: SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondView") as! SecondViewController
        let navigationVC: UINavigationController = swVC.frontViewController as! UINavigationController
        if (navigationVC.topViewController is SecondViewController) {
            swVC.revealToggle(animated: true)
            return
        }
        navigationVC.pushViewController(vc, animated: false)
        swVC.pushFrontViewController(navigationVC, animated: true)

    }
}
