//
//  BaseViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import SWRevealViewController
import LCNetwork
import CryptoSwift

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupNavigation() {
        if self.revealViewController() != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_leftButton"), style: .plain, target: self.revealViewController(), action: #selector(revealViewController().revealToggle(_:)))
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_rightButton"), style: .plain, target: nil, action: nil)
            navigationItem.title = "婚禮籌備平台"
            self.navigationController?.navigationBar.isTranslucent = false
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    func requestWithTask(task: BaseTaskNetwork, success: @escaping BlockSuccess, failure: @escaping BlockFailure) {
        task.request(blockSucess: { (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
    }
    
    func downloadFileSuccess(task: BaseTaskNetwork, success: @escaping BlockSuccess, failure: @escaping BlockFailure) {
        task.downloadFileSuccess({ (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
    }
    
    func uploadFileSuccess(task: BaseTaskNetwork, success: @escaping BlockSuccess, failure: @escaping BlockFailure) {
        task.upLoadFile({ (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
    }
    
    func downloadMemberExcel(byHuman: String, url: String) {
        let getMemberTask: DowloadMemberList = DowloadMemberList(linkUrl: url)
        downloadFileSuccess(task: getMemberTask, success: { (data) in
            let activityVC: UIActivityViewController =
                UIActivityViewController.init(activityItems: [data!], applicationActivities: nil)
            if (byHuman == "man") {
                Constants.sharedInstance.man?.filePath = data as! URL
            } else {
                Constants.sharedInstance.woman?.filePath = data as! URL
            }
            self.present(activityVC, animated: true, completion: nil)
        }) { (error) in
                _ = UIAlertController.showAlertWith(title: "",
                                                message: "不能下載賓客規劃表",
                                                myViewController: self)
        }
    }
    
    func uploadExcel(url: URL) {
        let uploadTask: UploadMemberTask = UploadMemberTask(fileUrl: url)
        uploadFileSuccess(task: uploadTask, success: { (data) in
            _ = UIAlertController.showAlertWith(title: "",
                                                message: data as! String,
                                                myViewController: self)
        }) { (error) in
            if let dictionary = error as? [String: Any] {
                let mesage: String = (dictionary["ErrMsg"] as? String)!
                _ = UIAlertController.showAlertWith(title: "",
                                                    message: mesage,
                                                    myViewController: self)
            }
        }
    }
    
    func shareApp() {
        let myAccount: Account = Account.getAccount()
        let memberURL = myAccount.memberURL
        let textToShare = "洪世瑋＆張鈞萍 宴客邀約平台\r\n \(memberURL)\r\n請進入 \"貴賓回函\" \r\n回覆參加人數，期待您的出席\r\n"
        if let myWebsite = NSURL(string: memberURL) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }

    func processNumberNotification() {
        let myAccount = Account.getAccount()
        let newNumberGuest = (Constants.sharedInstance.man?.numberGuest)! + (Constants.sharedInstance.woman?.numberGuest)!
        let newNumberMessage = Int(5)
        let linkTable = Constants.sharedInstance.woman?.tableSeat
        let linkWedStep = Constants.sharedInstance.woman?.webStep
        var newNumberNotificationOfSeat: Int = 0
        if ((linkTable?.characters.count)! > 0) {
            newNumberNotificationOfSeat += 1
        } else if ((linkWedStep?.characters.count)! > 0){
            newNumberNotificationOfSeat += 1
        }
        
        let guestNotification = newNumberGuest - myAccount.numberGuest
        
        Constants.sharedInstance.currentNotificationGuest = guestNotification + myAccount.currentGuestNumberBadge
        let messageNotification = newNumberMessage - myAccount.numberMessage
        Constants.sharedInstance.currentNotificationMessage = messageNotification +  myAccount.currentMessageNumberBadge
        let seatNotification = newNumberNotificationOfSeat - myAccount.tableNotification
        Constants.sharedInstance.currentNotificationSeat = seatNotification + myAccount.currentSeatNumberBadge
        
        myAccount.numberGuest = newNumberGuest
        myAccount.numberMessage = newNumberMessage
        myAccount.tableNotification = newNumberNotificationOfSeat
        myAccount.currentGuestNumberBadge =  Constants.sharedInstance.currentNotificationGuest!
        myAccount.currentMessageNumberBadge = Constants.sharedInstance.currentNotificationMessage!
        myAccount.currentSeatNumberBadge = Constants.sharedInstance.currentNotificationSeat!
        Account.saveAccount(myAccount: myAccount)
    }
    
}
