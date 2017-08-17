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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWdding()
        setupNavigation()
        setupNotification()
    }
    
    func setupNotification() {
        let myAccount: Account = Account.getAccount()
        numberGuest.text = String(myAccount.numberGuest)
        numberNotificationSeat.text = String(myAccount.tableNotification)
        numberMessage.text = String(myAccount.numberMessage)
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
        //get number guest:man+woman = number heart
        UIApplication.shared.openURL(URL(string: Account.getAccount().memberURL)!)
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
        self.navigationController?.pushViewController(secondVC, animated: false)
    }
    
    @IBAction func openWedForLogined(_ sender: Any) {
        //get url imag? and wedstep? = numberheart
        UIApplication.shared.openURL(URL(string: linkWebLogin)!)
    }
    
    @IBAction func sendImageOfSeatPosition(_ sender: Any) {
        sendImageOfPosition()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
