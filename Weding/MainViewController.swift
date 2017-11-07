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
    
    var isNewMessage: Bool = false {
        didSet {
            viewNumberMessage.isHidden = !isNewMessage
        }
    }
    var isNewGuest: Bool = false {
        didSet {
            viewNumberGuest.isHidden = !isNewGuest
        }
    }
    var isNewSeat: Bool = false {
        didSet {
            viewNumberSeat.isHidden = !isNewSeat
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWdding()
        setupNavigation()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNumberNotification(notification:)), name: NSNotification.Name(rawValue: "refreshNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(requestToServer(notification:)), name: NSNotification.Name(rawValue: "requestToServer"), object: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_rightButton"), style: .plain, target: nil, action: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotification()
    }
    
    func setupNotification() {
        let numberGestNotification = Constants.sharedInstance.currentNotificationGuest
        let numberMessageNotification = Constants.sharedInstance.currentNotificationMessage
        let numberSeatNotification = Constants.sharedInstance.currentNotificationSeat
        isNewGuest = (numberGestNotification > 0) ? true : false
        numberGuest.text = (numberGestNotification > 9) ? "9" : String(numberGestNotification)
        
        isNewMessage = (numberMessageNotification > 0) ? true : false
        numberMessage.text = (numberMessageNotification > 9) ? "9" : String(numberMessageNotification)
        
        isNewSeat = (numberSeatNotification > 0) ? true : false
        numberNotificationSeat.text = (numberSeatNotification > 9) ? "9" : String(numberSeatNotification)
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
        isNewGuest = false
        Constants.sharedInstance.currentNotificationGuest = 0
        let myAccount = Account.getAccount()
        myAccount.currentGuestNumberBadge = 0
        Account.saveAccount(myAccount: myAccount)
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        shareApp()
    }
    
    @IBAction func downloadMemberList(_ sender: Any) {
        let excelVC = self.storyboard?.instantiateViewController(withIdentifier: "ExcelController") as? ExcelController
        self.navigationController?.pushViewController(excelVC!, animated: false)
    }
   
    @IBAction func openSecondView(_ sender: Any) {
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondView") as? SecondViewController
        isNewMessage = false
        Constants.sharedInstance.currentNotificationMessage = 0
        let myAccount = Account.getAccount()
        myAccount.currentMessageNumberBadge = 0
        Account.saveAccount(myAccount: myAccount)
        navigationController?.pushViewController(secondVC!, animated: false)
    }
    
    @IBAction func openWedForLogined(_ sender: Any) {
        let webLogined = linkWebLogin + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess
        UIApplication.shared.openURL(URL(string: webLogined)!)
        isNewSeat = false
        Constants.sharedInstance.currentNotificationSeat = 0
        let myAccount = Account.getAccount()
        myAccount.currentSeatNumberBadge = 0
        Account.saveAccount(myAccount: myAccount)
    }
    
    @IBAction func sendImageOfSeatPosition(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SendImageSeatViewController") as? SendImageSeatViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func reloadNumberNotification(notification: Notification) {
       let name = (notification.object as? String)!
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
    
    @objc func requestToServer(notification: Notification) {
        let request = LoginTask(name: Account.getAccount().name, pass: Account.getAccount().pass)
        requestWithTask(task: request) { (_) in
            self.processNumberNotification()
            self.setupNotification()
        }
    }
}
