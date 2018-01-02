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
        showActivity(inView: self.view)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNumberNotification(notification:)), name: NSNotification.Name(rawValue: "refreshNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(requestToServer(notification:)), name: NSNotification.Name(rawValue: "recivePush"), object: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_rightButton"), style: .plain, target: nil, action: nil)
        processNumberNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotification()
    }
    
    func setupNotification() {
        let numberGestNotification = Constants.shared.newGuest
        let numberMessageNotification = Constants.shared.newMessage
        let numberSeatNotification = Constants.shared.newSeat
        isNewGuest = (numberGestNotification > 0) ? true : false
        numberGuest.text = (numberGestNotification > 9) ? "9" : String(numberGestNotification)
        
        isNewMessage = (numberMessageNotification > 0) ? true : false
        numberMessage.text = (numberMessageNotification > 9) ? "9" : String(numberMessageNotification)
        
        isNewSeat = (numberSeatNotification > 0) ? true : false
        numberNotificationSeat.text = (numberSeatNotification > 9) ? "9" : String(numberSeatNotification)
    }
    
    func setupWdding() {
        manName.text = Constants.shared.man?.name
        manCounterDay.text = Constants.shared.man?.counterDay
        let numberManCustomer = String(Constants.shared.man!.numberGuest)
        manNumberClient.text =  numberManCustomer
        
        womanName.text = Constants.shared.woman?.name
        womanCounterDay.text = Constants.shared.woman?.counterDay
        let numberWonmanCustomer = String(Constants.shared.woman!.numberGuest)
        womanNumberClient.text = numberWonmanCustomer
        nameFactory.text = Constants.shared.factory?.getName()
    }
    
    func processNumberNotification() {
        let task = GetNumberNoticeTask()
        requestWithTask(task: task) { (data) in
            if let numberNotice = data as? (Int, Int, Int) {
                Constants.shared.newMessage = numberNotice.0
                Constants.shared.newGuest = numberNotice.1
                Constants.shared.newSeat = numberNotice.2
                self.setupNotification()
                self.stopActivityIndicator()
            }
        }
    }

    @IBAction func openWeb(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: Account.getAccount().memberURL)!)
        isNewGuest = false
        Constants.shared.newGuest = 0
        let task = UpdateNumberNotice(type: 3)
        task.request(blockSucess: { (_) in
            
        }) { (_) in
            
        }
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        shareApp()
    }
    
    @IBAction func downloadMemberList(_ sender: Any) {
        let excelVC = self.storyboard?.instantiateViewController(withIdentifier: "ExcelController") as? ExcelController
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: excelVC!)
        swVC?.pushFrontViewController(navigationController, animated: true)
    }
   
    @IBAction func openSecondView(_ sender: Any) {
        self.isNewMessage = false
        Constants.shared.newMessage = 0
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondView") as? SecondViewController
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: secondVC!)
        swVC?.pushFrontViewController(navigationController, animated: true)
    }
    
    @IBAction func openWedForLogined(_ sender: Any) {
        let webLogined = linkWebLogin + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess
        UIApplication.shared.openURL(URL(string: webLogined)!)
        isNewSeat = false
        Constants.shared.newSeat = 0
        let task = UpdateNumberNotice(type: 2)
        task.request(blockSucess: { (_) in}) { (_) in}
    }
    
    @IBAction func sendImageOfSeatPosition(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SendImageSeatViewController") as? SendImageSeatViewController {
            let navigationController: UINavigationController = UINavigationController.init(rootViewController: vc)
            swVC?.pushFrontViewController(navigationController, animated: true)
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
            Constants.shared.newGuest = 0
        case "message":
            viewNumberGuest.isHidden = true
            Constants.shared.newMessage = 0
        default:
            viewNumberSeat.isHidden = true
            Constants.shared.newSeat = 0
        }
    }
    
    @objc func requestToServer(notification: Notification) {
        guard let name = notification.object as? String else {
            return
        }
        switch name {
        case "VIPLetter":
            Constants.shared.newGuest += 1
        case "GuestAddMessageToMember":
            Constants.shared.newMessage += 1
        case "FACTORY_DOC_TABLE_UPLOAD", "FACTORY_DOC_WEDSTEP_UPLOAD", "MEMBER_DOC_OPEN_1", "MEMBER_DOC_OPEN_2", "MEMBER_DOC_OPEN_3", "MEMBER_DOC_TOFAC_4", "MEMBER_DOC_TOFAC_5":
            Constants.shared.newSeat += 1
        default:
            processNumberNotification()
        }
        self.setupNotification()
    }
}
