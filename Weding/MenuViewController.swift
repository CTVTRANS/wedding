//
//  MenuViewController.swift
//  Weding
//
//  Created by kien le van on 8/5/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import SWRevealViewController

class MenuViewController: BaseViewController, SWRevealViewControllerDelegate {

    @IBOutlet weak var table: UITableView!
    var arrayRow = ["檢視邀約平台", "分享邀約平台", "賓客規劃表", "發送即時訊息", "婚禮管家", "桌位圖表發佈賓客"]

    let notificationName = Notification.Name("refreshNotification")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        self.revealViewController().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }

    func openWebDetail() {
        UIApplication.shared.openURL(URL(string: Account.getAccount().memberURL)!)
        swVC?.revealToggle(animated: false)
        Constants.shared.newGuest = 0
        let task = UpdateNumberNotice(type: 3)
        task.request(blockSucess: { (_) in}) { (_) in}
        NotificationCenter.default.post(name: notificationName, object: "guest")
        return
    }
    
    func openWebLogined() {
        let webLogined = linkWebLogin + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess
        UIApplication.shared.openURL(URL(string: webLogined)!)
        swVC?.revealToggle(animated: false)
        NotificationCenter.default.post(name: notificationName, object: "seat")
        Constants.shared.newSeat = 0
        let task = UpdateNumberNotice(type: 2)
        task.request(blockSucess: { (_) in}) { (_) in}
        return
    }
    
    func showSecondView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondView") as? SecondViewController
        let navigationVC: UINavigationController = UINavigationController.init(rootViewController: vc!)
        swVC?.pushFrontViewController(navigationVC, animated: true)
    }
    
    @IBAction func pressHome(_ sender: Any) {
        let navigationVC = swVC?.frontViewController as? UINavigationController
        navigationVC?.popToRootViewController(animated: false)
        swVC?.pushFrontViewController(navigationVC, animated: true)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuViewCell
        cell?.binData(name: arrayRow[indexPath.row], index: indexPath.row)
        return cell!
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
            Constants.shared.newMessage = 0
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
        navigationVC?.pushViewController(vc!, animated: false)
        swVC?.pushFrontViewController(navigationVC, animated: true)
    }
}
