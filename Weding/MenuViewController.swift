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
    var arrayRow = ["檢視邀約平台", "分享邀約平台", "賓客規劃表", "發送即時訊息", "婚禮管家", "桌位圖表發佈賓客"]

    let notificationName = Notification.Name("refreshNotification")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        self.revealViewController().delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(requestToServer(notification:)), name: NSNotification.Name(rawValue: "requestToServer"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuViewCell
        cell?.binData(name: arrayRow[indexPath.row], index: indexPath.row)
        return cell!
    }
    
    func openWebDetail() {
        UIApplication.shared.openURL(URL(string: Account.getAccount().memberURL)!)
        swVC?.revealToggle(animated: false)
        Constants.sharedInstance.currentNotificationGuest = 0
        let myAccount = Account.getAccount()
        myAccount.currentGuestNumberBadge = 0
        Account.saveAccount(myAccount: myAccount)
        NotificationCenter.default.post(name: notificationName, object: "guest")
        return
    }
    
    func openWebLogined() {
        let webLogined = linkWebLogin + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess
        UIApplication.shared.openURL(URL(string: webLogined)!)
        swVC?.revealToggle(animated: false)
        NotificationCenter.default.post(name: notificationName, object: "seat")
        Constants.sharedInstance.currentNotificationSeat = 0
        let myAccount = Account.getAccount()
        myAccount.currentSeatNumberBadge = 0
        Account.saveAccount(myAccount: myAccount)
        return
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        table.deselectRow(at: indexPath, animated: false)
        let navigationVC = swVC?.frontViewController as? UINavigationController
        var vc: UIViewController? = nil
        switch row {
        case 0:
            openWebDetail()
            return
        case 1:
            swVC?.revealToggle(animated: true)
            shareApp()
            return
        case 2:
            if navigationVC?.topViewController is ExcelController {
                swVC?.revealToggle(animated: true)
                return
            }
            vc = self.storyboard?.instantiateViewController(withIdentifier: "ExcelController") as? ExcelController
        case 3:
            if navigationVC?.topViewController is SecondViewController {
                swVC?.revealToggle(animated: true)
                return
            }
            NotificationCenter.default.post(name: notificationName, object: "message")
            Constants.sharedInstance.currentNotificationMessage = 0
            let myAccount = Account.getAccount()
            myAccount.currentMessageNumberBadge = 0
            Account.saveAccount(myAccount: myAccount)
            vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondView") as? SecondViewController
        case 4:
            openWebLogined()
            return
        case 5:
            swVC?.revealToggle(animated: true)
            vc = storyboard?.instantiateViewController(withIdentifier: "SendImageSeatViewController") as? SendImageSeatViewController
        default:
            break
        }
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: vc!)
        swVC?.pushFrontViewController(navigationController, animated: true)
    }
    
    func showSecondView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondView") as? SecondViewController
        let navigationVC: UINavigationController = UINavigationController.init(rootViewController: vc!)
        swVC?.pushFrontViewController(navigationVC, animated: true)
    }
    
    @objc func requestToServer(notification: Notification) {
        let request = LoginTask(name: Account.getAccount().name, pass: Account.getAccount().pass)
        requestWithTask(task: request) { (_) in
            self.processNumberNotification()
            self.table.reloadData()
        }
    }
}
