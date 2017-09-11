//
//  SecondViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var manName: UILabel!
    @IBOutlet weak var womanName: UILabel!
    @IBOutlet weak var manCounterDay: UILabel!
    @IBOutlet weak var womanCounterDay: UILabel!
    @IBOutlet weak var manNumberClient: UILabel!
    @IBOutlet weak var womanNumberClient: UILabel!
    @IBOutlet weak var nameFactory: UILabel!
    
    @IBOutlet weak var numberGuest: UILabel!
    @IBOutlet weak var numberMessage: UILabel!
    @IBOutlet weak var numberNotificationSeat: UILabel!
    @IBOutlet weak var viewNumberGuest: UIView!
    @IBOutlet weak var viewNumberMessage: UIView!
    @IBOutlet weak var viewNumberSeat: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWdding()
        setupNavigation()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNumberNotification(notification:)), name: NSNotification.Name(rawValue: "refreshNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(requestToServer(notification:)), name: NSNotification.Name(rawValue: "requestToServer"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotification()
    }
    
    func setupNotification() {
        let numberGestNotification: Int = Constants.sharedInstance.currentNotificationGuest!
        let numberMessageNotification: Int = Constants.sharedInstance.currentNotificationMessage!
        let numberSeatNotification: Int = Constants.sharedInstance.currentNotificationSeat!

        if numberGestNotification > 9 {
             numberGuest.text = "9"
        } else if (numberGestNotification == 0){
             viewNumberGuest.isHidden = true
        } else {
            numberGuest.text = String(numberGestNotification)
        }

        if (numberMessageNotification > 9) {
            numberMessage.text = "9"
        } else if (numberMessageNotification == 0) {
            viewNumberMessage.isHidden = true
        } else {
            numberMessage.text = String(numberMessageNotification)
        }
        
        if (numberSeatNotification > 0) {
             numberNotificationSeat.text = String(numberSeatNotification)
        } else {
            viewNumberSeat.isHidden = true
        }
    }
    
    func setupWdding() {
        manName.text = Constants.sharedInstance.man?.name
        manCounterDay.text = Constants.sharedInstance.man?.counterDay
        let numberManCustomer = String(Constants.sharedInstance.man!.numberGuest)
        manNumberClient.text =  numberManCustomer
        
        womanName.text = Constants.sharedInstance.woman?.name
        womanCounterDay.text = Constants.sharedInstance.woman?.counterDay
        let numberWonmanCustomer = String(Constants.sharedInstance.woman!.numberGuest)
        womanNumberClient.text = numberWonmanCustomer
        nameFactory.text = Constants.sharedInstance.factory?.getName()
    }

    @IBAction func openWeb(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: Account.getAccount().memberURL)!)
        viewNumberGuest.isHidden = true
        Constants.sharedInstance.currentNotificationGuest = 0
        let myAccount = Account.getAccount()
        myAccount.currentGuestNumberBadge = 0
        Account.saveAccount(myAccount: myAccount)
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        shareApp()
    }
    
    @IBAction func downloadMemberList(_ sender: Any) {
        let excelVC: ExcelController = self.storyboard?.instantiateViewController(withIdentifier: "ExcelController") as! ExcelController
        self.navigationController?.pushViewController(excelVC, animated: false)
    }
   
   
    @IBAction func openSecondView(_ sender: Any) {
        let secondVC: SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondView") as! SecondViewController
        viewNumberMessage.isHidden = true
        Constants.sharedInstance.currentNotificationMessage = 0
        let myAccount = Account.getAccount()
        myAccount.currentMessageNumberBadge = 0
        Account.saveAccount(myAccount: myAccount)
        self.navigationController?.pushViewController(secondVC, animated: false)
    }
    
    @IBAction func openWedForLogined(_ sender: Any) {
        let webLogined = linkWebLogin + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess
        UIApplication.shared.openURL(URL(string: webLogined)!)
        viewNumberSeat.isHidden = true
        Constants.sharedInstance.currentNotificationSeat = 0
        let myAccount = Account.getAccount()
        myAccount.currentSeatNumberBadge = 0
        Account.saveAccount(myAccount: myAccount)
    }
    
    @IBAction func sendImageOfSeatPosition(_ sender: Any) {
        sendImageOfPosition()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func reloadNumberNotification(notification: Notification) {
       let name = notification.object as! String
        switch name {
        case "guest":
            viewNumberGuest.isHidden = true
            Constants.sharedInstance.currentNotificationGuest = 0
        case "message":
            viewNumberGuest.isHidden = true
            Constants.sharedInstance.currentNotificationGuest = 0
        default:
            viewNumberSeat.isHidden = true
            Constants.sharedInstance.currentNotificationSeat = 0
        }
    }
    
    func requestToServer(notification: Notification) {
        let request = LoginTask(name: Account.getAccount().name, pass: Account.getAccount().pass)
        requestWithTask(task: request, success: { (data) in
            self.processNumberNotification()
            self.setupNotification()
        }) { (error) in
            
        }
    }
}
